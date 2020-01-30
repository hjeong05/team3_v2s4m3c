package dev.mvc.pdcontents;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.pdatfile.PdatfileProcInter;
import dev.mvc.pdatfile.PdatfileVO;
import dev.mvc.pdreply.PdreplyProcInter;
import dev.mvc.productcate.ProductcateProcInter;
import dev.mvc.productcate.ProductcateVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class PdcontentsCont {
  @Autowired
  @Qualifier("dev.mvc.pdcontents.PdcontentsProc")
  private PdcontentsProcInter pdcontentsProc;

  @Autowired
  @Qualifier("dev.mvc.productcate.ProductcateProc")
  private ProductcateProcInter productcateProc;
  
  @Autowired
  @Qualifier("dev.mvc.pdatfile.PdatfileProc")
  private PdatfileProcInter pdatfileProc;
  
  @Autowired
  @Qualifier("dev.mvc.pdreply.PdreplyProc")
  private PdreplyProcInter pdreplyProc;
  
  public PdcontentsCont() {
    System.out.println("--> PdcontentsCont created.");
  }

  // http://localhost:9090/ojt/contents/create.do?memberno=1&categrpno=1
  @RequestMapping(value = "/pdcontents/create.do", method = RequestMethod.GET)
  public ModelAndView create(int productcateno) {
    ModelAndView mav = new ModelAndView();

    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    mav.setViewName("/pdcontents/create"); // /webapp/contents/create.jsp

    return mav;
  }

  @RequestMapping(value = "/pdcontents/create.do", method = RequestMethod.POST)
  public ModelAndView create(RedirectAttributes redirectAttributes, HttpServletRequest request,
                                           PdcontentsVO pdcontentsVO) {
    ModelAndView mav = new ModelAndView();

 // -----------------------------------------------------
    // 파일 전송 코드 시작
    // -----------------------------------------------------
    String fname = ""; // 원본 파일명
    String fupname = ""; // 업로드된 파일명
    long fsize = 0;  // 파일 사이즈
    String thumb = ""; // Preview 이미지
    
    String upDir = Tool.getRealPath(request, "/pdcontents/storage");
    // 전송 파일이 없어서도 fnameMF 객체가 생성됨, 하나의 파일 업로드.
    MultipartFile fnameMF = pdcontentsVO.getFnameMF();
    fsize = fnameMF.getSize();  // 파일 크기
    if (fsize > 0) { // 파일 크기 체크
      fname = fnameMF.getOriginalFilename(); // 원본 파일명
      fupname = Upload.saveFileSpring(fnameMF, upDir); // 파일 저장
          
      if (Tool.isImage(fname)) { // 이미지인지 검사
        thumb = Tool.preview(upDir, fupname, 160, 120); // thumb 이미지 생성
      }
    }
    pdcontentsVO.setFname(fname);
    pdcontentsVO.setFupname(fupname);
    pdcontentsVO.setThumb(thumb);
    pdcontentsVO.setFsize(fsize);
    // -----------------------------------------------------
    // 파일 전송 코드 종료
    // -----------------------------------------------------
    int count = pdcontentsProc.create(pdcontentsVO);

    if (count == 1) {
      productcateProc.increaseCnt(pdcontentsVO.getProductcateno()); // 카테고리 글수 증가
    }
    
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("productcateno", pdcontentsVO.getProductcateno());
    
    mav.setViewName("redirect:/pdcontents/create_msg.jsp");

    return mav;
  }

  @RequestMapping(value = "/pdcontents/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();

    List<PdcontentsVO> list = pdcontentsProc.list_all();
    
    mav.addObject("list", list);
    mav.setViewName("/pdcontents/list_all"); // /webapp/contents/list_all.jsp

    return mav;
  }

  // 상품 별 상세설명 
  // http://localhost:9090/team3/cart/cartlist.do?cartgrpno=1
  @RequestMapping(value = "/pdcontents/pdread.do", method = RequestMethod.GET)
  public ModelAndView pdread(int pdcontentsno) {
    ModelAndView mav = new ModelAndView();

    PdcontentsVO pdcontentsVO = pdcontentsProc.read(pdcontentsno);
    mav.addObject("pdcontentsVO", pdcontentsVO);

    ProductcateVO productcateVO = productcateProc.read(pdcontentsVO.getProductcateno());
    mav.addObject("productcateVO", productcateVO);
    
    List<PdcontentsVO> pdcontents_list = pdcontentsProc.list_by_productcateno(pdcontentsVO.getProductcateno());
    mav.addObject("pdcontents_list", pdcontents_list);
    
    List<PdatfileVO> pdatfile_list = pdatfileProc.list_by_pdcontentsno(pdcontentsno);
    mav.addObject("pdatfile_list", pdatfile_list);
    
    mav.setViewName("/pdcontents/pdread");

    return mav;
  }
  
  /**
   * 카테고리 그룹별 목록
   * http://localhost:9090/team3/pdcontents/list_by_productcateno.do?productcateno=1
   * @param productcateno
   * @return
   */
  @RequestMapping(value = "/pdcontents/list_by_productcateno.do", method = RequestMethod.GET)
  public ModelAndView list_by_productcateno(int productcateno) {
    ModelAndView mav = new ModelAndView();
    
    List<PdcontentsVO> list = pdcontentsProc.list_by_productcateno(productcateno);
    mav.addObject("list", list);
    // /webapp/contents/list.jsp

    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    mav.setViewName("/pdcontents/list_by_productcateno"); // 카테고리 그룹별 목록

    return mav;
  }

  /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9090/ojt/pdcontents/list.do
   * http://localhost:9090/ojt/pdcontents/list.do?productcateno=1&word=스위스&nowPage=1
   * @param categoryno
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/pdcontents/list.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_productcateno_search_paging(
      @RequestParam(value="productcateno", defaultValue="1") int productcateno,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    // /contents/list_by_categrpno_search_paging.jsp
    mav.setViewName("/pdcontents/list_by_productcateno_search_paging");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("productcateno", productcateno); // #{categrpno}
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);       
    
    // 검색 목록
    List<PdcontentsVO> list = pdcontentsProc.list_by_productcateno_search_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = pdcontentsProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * 
     * @param listFile 목록 파일명 
     * @param categrpno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = pdcontentsProc.pagingBox("list.do", productcateno, search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }    
 
  
  /**
   * productcateno별 전체 목록 // 검색어 포함
   * @param categrpno
   * @param word
   * @return
   */
 /* @RequestMapping(value = "/pdcontents/list.do", method = RequestMethod.GET)
  public ModelAndView list_by_productcateno_search_paging(
      @RequestParam(value="productcateno", defaultValue="1") int productcateno,
      @RequestParam(value="word", defaultValue="") String word,
//      @RequestParam(value="nowPage", defaultValue="1") int nowPage) 
      {
  //  System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();

    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("productcateno", productcateno);
    map.put("word", word);
 //   map.put("nowPage", nowPage);  
    
    List<PdcontentsVO> list = pdcontentsProc.list_by_productcateno(productcateno);
    mav.addObject("list", list);

    int search_count = pdcontentsProc.search_count(map);
    mav.addObject("search_count", search_count);
    
    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    mav.setViewName("/pdcontents/list_by_productcateno_search"); // 카테고리 그룹별 목록

 //   String paging = pdcontentsProc.pagingBox("list.do", productcateno, search_count, nowPage, word);
 //   mav.addObject("paging", paging);
    
 //   mav.addObject("nowPage", nowPage);
    return mav;
  }*/
  
  /**
   * 조회 http://localhost:9090/ojt/contents/read.do?contentsno=1
   * 
   * @param contentsno
   * @return
   */
  @RequestMapping(value = "/pdcontents/read.do", method = RequestMethod.GET)
  public ModelAndView read(int pdcontentsno) {
    ModelAndView mav = new ModelAndView();

    PdcontentsVO pdcontentsVO = pdcontentsProc.read(pdcontentsno);
    mav.addObject("pdcontentsVO", pdcontentsVO);

    ProductcateVO productcateVO = productcateProc.read(pdcontentsVO.getProductcateno());
    mav.addObject("productcateVO", productcateVO);
    
    List<PdcontentsVO> pdcontents_list = pdcontentsProc.list_by_productcateno(pdcontentsVO.getProductcateno());
    mav.addObject("pdcontents_list", pdcontents_list);
    
    List<PdatfileVO> pdatfile_list = pdatfileProc.list_by_pdcontentsno(pdcontentsno);
    mav.addObject("pdatfile_list", pdatfile_list);
    
    mav.setViewName("/pdcontents/read");

    return mav;
  }
 
  
  /**
   * 수정 폼 GET
   * @param categrpno
   * @param contentsno
   * @return
   */
  // http://localhost:9090/ojt/contents/update.do?memberno=1&categrpno=1
  @RequestMapping(value = "/pdcontents/update.do", method = RequestMethod.GET)
  public ModelAndView update(int productcateno, int pdcontentsno) {
    ModelAndView mav = new ModelAndView();

    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    PdcontentsVO pdcontentsVO = pdcontentsProc.read(pdcontentsno);
    mav.addObject("pdcontentsVO", pdcontentsVO);

    mav.setViewName("/pdcontents/update"); // /webapp/contents/update.jsp

    return mav;
  }
  
  /**
   * 수정 처리
   * @param contentsVO
   * @return
   */
  @RequestMapping(value = "/pdcontents/update.do", 
                             method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes ra,
                                        PdcontentsVO pdcontentsVO,
                                        int nowPage) {
    ModelAndView mav = new ModelAndView();

    int count = pdcontentsProc.update(pdcontentsVO);

    // mav.setViewName("/contents/create"); // /webapp/contents/create.jsp
    // redirect: form에서 보낸 데이터 모두 삭제됨, 새로고침 중복 등록 방지용.
    ra.addAttribute("count", count);
    ra.addAttribute("productcateno", pdcontentsVO.getProductcateno());
    ra.addAttribute("pdcontentsno", pdcontentsVO.getPdcontentsno());
    ra.addAttribute("nowPage", nowPage);
    
    mav.setViewName("redirect:/pdcontents/update_msg.jsp");

    return mav;
  }
  
  /**
   * 썸네일 수정 폼 GET
   * @param categrpno
   * @param contentsno
   * @return
   */
  // http://localhost:9090/ojt/contents/update.do?memberno=1&categrpno=1
  @RequestMapping(value = "/pdcontents/update_thumb.do", method = RequestMethod.GET)
  public ModelAndView update_thumb(int productcateno, int pdcontentsno) {
    ModelAndView mav = new ModelAndView();

    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    PdcontentsVO pdcontentsVO = pdcontentsProc.read(pdcontentsno);
    mav.addObject("pdcontentsVO", pdcontentsVO);

    mav.setViewName("/pdcontents/update_thumb"); // /webapp/contents/update.jsp

    return mav;
  }
  
  /**
   * 썸네일 수정 처리
   * @param contentsVO
   * @return
   */
  @RequestMapping(value = "/pdcontents/update_thumb.do", 
                             method = RequestMethod.POST)
  public ModelAndView update_thumb(RedirectAttributes redirectAttributes, HttpServletRequest request,
                                        PdcontentsVO pdcontentsVO) {
    ModelAndView mav = new ModelAndView();
    
    // -----------------------------------------------------
    // 파일 전송 코드 시작
    // -----------------------------------------------------
    String fname = ""; // 원본 파일명
    String fupname = ""; // 업로드된 파일명
    long fsize = 0;  // 파일 사이즈
    String thumb = ""; // Preview 이미지
    
    String upDir = Tool.getRealPath(request, "/pdcontents/storage");
    // 전송 파일이 없어서도 fnameMF 객체가 생성됨, 하나의 파일 업로드.
    MultipartFile fnameMF = pdcontentsVO.getFnameMF();
    fsize = fnameMF.getSize();  // 파일 크기
    if (fsize > 0) { // 파일 크기 체크
      fname = fnameMF.getOriginalFilename(); // 원본 파일명
      fupname = Upload.saveFileSpring(fnameMF, upDir); // 파일 저장
          
      if (Tool.isImage(fname)) { // 이미지인지 검사
        thumb = Tool.preview(upDir, fupname, 200, 160); // thumb 이미지 생성
      }
    }
    pdcontentsVO.setFname(fname);
    pdcontentsVO.setFupname(fupname);
    pdcontentsVO.setThumb(thumb);
    pdcontentsVO.setFsize(fsize);
    // -----------------------------------------------------
    // 파일 전송 코드 종료
    // -----------------------------------------------------
    int count = pdcontentsProc.update_thumb(pdcontentsVO);

    // mav.setViewName("/contents/create"); // /webapp/contents/create.jsp
    // redirect: form에서 보낸 데이터 모두 삭제됨, 새로고침 중복 등록 방지용.
    redirectAttributes.addAttribute("count", count);
    redirectAttributes.addAttribute("productcateno", pdcontentsVO.getProductcateno());
    redirectAttributes.addAttribute("pdcontentsno", pdcontentsVO.getPdcontentsno());
    
    mav.setViewName("redirect:/pdcontents/update_thumb_msg.jsp");

    return mav;
  }
  
  /**
   * 한 건 삭제 폼
   * @param productcateno
   * @param pdcontentsno
   * @return
   */
  // http://localhost:9090/ojt/pdcontents/delete.do?productcateno=1&pdcontentsno=1
  @RequestMapping(value = "/pdcontents/delete.do", 
                             method = RequestMethod.GET)
  public ModelAndView delete(int productcateno, int pdcontentsno) {
    ModelAndView mav = new ModelAndView();

    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    PdcontentsVO pdcontentsVO = pdcontentsProc.read(pdcontentsno);
    mav.addObject("pdcontentsVO", pdcontentsVO);
    
    // FK pdcontentsno 컬럼 값이 사용된 레코드 갯수 산출 : id = "count_by_contentsno"
    int count_by_pdcontentsno = pdatfileProc.count_by_pdcontentsno(pdcontentsno);
    mav.addObject("count_by_pdcontentsno", count_by_pdcontentsno);

    mav.setViewName("/pdcontents/delete"); // /webapp/contents/delete.jsp

    return mav;
  }
  
  /**
   * 한 건 삭제 처리
   * @param session
   * @param ra
   * @param productcateno
   * @param pdcontentsno
   * @return
   */
  @RequestMapping(value = "/pdcontents/delete.do", 
      method = RequestMethod.POST)
  public ModelAndView delete( HttpSession session, 
      RedirectAttributes ra,
      int productcateno, 
      int pdcontentsno,
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
   // int memberno = (Integer)session.getAttribute("memberno");
    // 현재 로그인한 사용자와 글 등록자가 같은지 검사 
 //   if(memberno == contentsProc.read(contentsno).getMemberno()) {
      int count = pdcontentsProc.delete(pdcontentsno);
      if(count == 1) {
        productcateProc.decreaseCnt(productcateno);  // 글 개수 감소
        
     // -------------------------------------------------------------------------------------
        // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("productcateno", productcateno);
        map.put("word", word);
        if (pdcontentsProc.search_count(map) % Pdcontents.RECORD_PER_PAGE == 0) {
          nowPage = nowPage - 1;
          if (nowPage < 1) {
            nowPage = 1;
          }
        }
        // -------------------------------------------------------------------------------------
        
        
      }
      ra.addAttribute("count", count);
      ra.addAttribute("productcateno", productcateno);
      ra.addAttribute("pdcontentsno", pdcontentsno);
      ra.addAttribute("nowPage", nowPage);

      mav.setViewName("redirect:/pdcontents/delete_msg.jsp");
/*    } else {
      // ra.addAttribute("productcateno", productcateno);
      ra.addAttribute("nowPage", nowPage);
      mav.setViewName("redirect:/contents/auth_fail_msg.jsp");
    }*/
    return mav;
  }
  
  /**
   * FK 컬럼값을 이용한 레코드 삭제 처리
   * @param ra
   * @param categrpno
   * @return
   */
  @RequestMapping(value = "/pdcontents/delete_by_productcateno.do", 
                             method = RequestMethod.POST)
  public ModelAndView delete_by_productcateno(RedirectAttributes ra,
                                            int productcateno) {
    ModelAndView mav = new ModelAndView();

    int count = pdcontentsProc.delete_by_productcateno(productcateno);
    if (count > 0) { // FK 컬럼 관련 글이 정상적으로 삭제되었다면 cnt 컬럼 0으로변경
      productcateProc.cnt_zero(productcateno);
    }

    ra.addAttribute("count", count); // 삭제된 레코드 갯수
    ra.addAttribute("productcateno", productcateno);
    
    mav.setViewName("redirect:/pdcontents/delete_by_productcateno_msg.jsp");

    return mav;
  }
  
  /**
   * 첨부 파일 1건 삭제 폼
   * 
   * @param pdcontentsno
   * @return
   */
  @RequestMapping(value = "/pdcontents/file_delete.do", 
                             method = RequestMethod.GET)
  public ModelAndView file_delete(int pdcontentsno) {
    ModelAndView mav = new ModelAndView();

    PdcontentsVO pdcontentsVO = pdcontentsProc.read(pdcontentsno);
    mav.addObject("pdcontentsVO", pdcontentsVO);

    ProductcateVO productcateVO = productcateProc.read(pdcontentsVO.getProductcateno());
    mav.addObject("productcateVO", productcateVO);
    
    List<PdatfileVO> pdatfile_list = pdatfileProc.list_by_pdcontentsno(pdcontentsno);
    mav.addObject("pdatfile_list", pdatfile_list);
    
    mav.setViewName("/pdcontents/file_delete"); // file_delete.jsp

    return mav;
  }
  
  /**
   * 첨부 파일 1건 삭제 처리
   * 
   * @param pdcontentsno
   * @return
   */
  @RequestMapping(value = "/pdcontents/file_delete_proc.do", 
                             method = RequestMethod.GET)
  public ModelAndView file_delete_proc(HttpServletRequest request, int pdcontentsno, int pdatfileno) {
    ModelAndView mav = new ModelAndView();

    PdcontentsVO pdcontentsVO = pdcontentsProc.read(pdcontentsno);
    mav.addObject("pdcontentsVO", pdcontentsVO);

    ProductcateVO productcateVO = productcateProc.read(pdcontentsVO.getProductcateno());
    mav.addObject("productcateVO", productcateVO);

    // 삭제할 파일 정보를 읽어옴.
    PdatfileVO pdatfileVO = pdatfileProc.read(pdatfileno);
    
    String upDir = Tool.getRealPath(request, "/pdatfile/storage");  // 절대 경로
    Tool.deleteFile(upDir, pdatfileVO.getFupname()); // Folder에서 1건의 파일 삭제 
    Tool.deleteFile(upDir, pdatfileVO.getThumb()); // Folder에서 1건의 Thumb파일 삭제 
    
    // DBMS에서 1건의 파일 삭제
    pdatfileProc.delete(pdatfileno);
    
    List<PdatfileVO> pdatfile_list = pdatfileProc.list_by_pdcontentsno(pdcontentsno);
    mav.addObject("pdatfile_list", pdatfile_list);
    
    mav.setViewName("/pdcontents/file_delete"); // file_delete.jsp

    return mav;
  }
  
  /**
   * 댓글 삭제 시 패스워드 검사
   * @param pdreplyno
   * @param passwd
   * @return
   */
//http://localhost:9090/team3/pdcontents/pdreply_delete.do?pdreplyno=1&passwd=1234
  @ResponseBody
  @RequestMapping(value = "/pdcontents/pdreply_delete.do", 
                           method = RequestMethod.POST)
  public String reply_delete(int pdreplyno, String passwd) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("pdreplyno", pdreplyno);
    map.put("passwd", passwd);

    int count = pdreplyProc.checkPasswd(map); // 패스워드 검사
    int delete_count = 0;
    if (count == 1) {
      delete_count = pdreplyProc.delete(pdreplyno); // 댓글 삭제
    }
    
    JSONObject obj = new JSONObject();
    obj.put("count", count);
    obj.put("delete_count", delete_count);
    
    return obj.toString();
  }
  
}





