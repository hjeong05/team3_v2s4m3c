package dev.mvc.pdatfile;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.productcate.ProductcateProcInter;
import dev.mvc.productcate.ProductcateVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class PdatfileCont {
  @Autowired
  @Qualifier("dev.mvc.pdatfile.PdatfileProc")
  private PdatfileProcInter pdatfileProc;
  
  @Autowired
  @Qualifier("dev.mvc.productcate.ProductcateProc")
  private ProductcateProcInter productcateProc;
  
  public PdatfileCont() {
    System.out.println("--> PdatfileCont created.");
  }
  
  /**
   * ���� ��� ��
   * @param productcateno
   * @param pdcontentsno
   * @return
   */
  // http://localhost:9090/ojt/pdatfile/create.do?categrpno=1&contentsno=1
  @RequestMapping(value = "/pdatfile/create.do", method = RequestMethod.GET)
  public ModelAndView create(int productcateno, int pdcontentsno) {
    ModelAndView mav = new ModelAndView();

    ProductcateVO productcateVO = productcateProc.read(productcateno);
    mav.addObject("productcateVO", productcateVO);

    mav.setViewName("/pdatfile/create"); // /webapp/pdatfile/create.jsp

    return mav;
  }
  
  @RequestMapping(value = "/pdatfile/create.do", method = RequestMethod.POST)
  public ModelAndView create(RedirectAttributes ra,
                                           HttpServletRequest request,
                                           PdatfileVO pdatfileVO,
                                           int productcateno
                                         /*  int nowPage*/) {
    // System.out.println("--> productcateno: " + productcateno);
    
    ModelAndView mav = new ModelAndView();
    // -----------------------------------------------------
    // ���� ���� �ڵ� ����
    // -----------------------------------------------------
    int pdcontentsno = pdatfileVO.getPdcontentsno(); // �θ�� ��ȣ
    String fname = ""; // ���� ���ϸ�
    String fupname = ""; // ���ε�� ���ϸ�
    long fsize = 0;  // ���� ������
    String thumb = ""; // Preview �̹���
    int upload_count = 0; // ����ó���� ���ڵ� ����
    
    String upDir = Tool.getRealPath(request, "/pdatfile/storage");
    // ���� ������ ����� fnamesMF ��ü�� ������.
    List<MultipartFile> fnamesMF = pdatfileVO.getFnamesMF();
    int count = fnamesMF.size(); // ���� ���� ����
    if (count > 0) {
      for (MultipartFile multipartFile:fnamesMF) { // ���� ����
        fsize = multipartFile.getSize();  // ���� ũ��
        if (fsize > 0) { // ���� ũ�� üũ
          fname = multipartFile.getOriginalFilename(); // ���� ���ϸ�
          fupname = Upload.saveFileSpring(multipartFile, upDir); // ���� ����
          
          if (Tool.isImage(fname)) { // �̹������� �˻�
            thumb = Tool.preview(upDir, fupname, 120, 80); // thumb �̹��� ����
          }
        }
        PdatfileVO vo = new PdatfileVO();
        vo.setPdcontentsno(pdcontentsno);
        vo.setFname(fname);
        vo.setFupname(fupname);
        vo.setThumb(thumb);
        vo.setFsize(fsize);
        
        upload_count = upload_count + pdatfileProc.create(vo); // ���� 1�� ��� ���� dbms ����
      }
    }    
    // -----------------------------------------------------
    // ���� ���� �ڵ� ����
    // -----------------------------------------------------
    
    ra.addAttribute("upload_count", upload_count);
    ra.addAttribute("productcateno", productcateno);
    ra.addAttribute("pdcontentsno", pdatfileVO.getPdcontentsno());
 //   ra.addAttribute("nowPage", nowPage);
    
    mav.setViewName("redirect:/pdatfile/create_msg.jsp");
    return mav;
  }
  
  /**
   * ���
   * @return
   */
  @RequestMapping(value = "/pdatfile/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();

    List<PdatfileVO> list = pdatfileProc.list();
    mav.addObject("list", list);

    mav.setViewName("/pdatfile/list");

    return mav;
  }
  
  /**
   * ZIP ���� �� ���� �ٿ�ε�
   * @param request
   * @param contentsno ���� ����� �����ö� ����� �۹�ȣ
   * @return
   */
  @RequestMapping(value = "/pdatfile/downzip.do", 
                             method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int pdcontentsno) {
    ModelAndView mav = new ModelAndView();
    
    // �۹�ȣ�� �ش��ϴ� ���� ��� ����
    List<PdatfileVO> pdatfile_list = pdatfileProc.list_by_pdcontentsno(pdcontentsno);
    
    // ���� ����� ���ϸ� ����
    ArrayList<String> files_array = new ArrayList<String>();
    for(PdatfileVO pdatfileVO:pdatfile_list) {
      files_array.add(pdatfileVO.getFupname());
    }
    
    String dir = "/pdatfile/storage";
    String upDir = Tool.getRealPath(request, dir); // ���� ���
    
    // ����� ���ϸ�, ���� ������ �ٿ�ε��� �浹 ó��
    String zip = "download_files_" + Tool.getRandomDate() + ".zip"; 
    String zip_filename = upDir + zip;
    
    String[] zip_src = new String[files_array.size()]; // ���� ������ŭ �迭 ����
    
    for (int i=0; i < files_array.size(); i++) {
      zip_src[i] = upDir + "/" + files_array.get(i); // ���� ��� ����      
    }
 
    byte[] buffer = new byte[4096]; // 4 KB
    
    try {
      ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(zip_filename));
      
      for(int index=0; index < zip_src.length; index++) {
        FileInputStream in = new FileInputStream(zip_src[index]);
        
        Path path = Paths.get(zip_src[index]);
        String zip_src_file = path.getFileName().toString();
        // System.out.println("zip_src_file: " + zip_src_file);
        
        ZipEntry zipEntry = new ZipEntry(zip_src_file);
        zipOutputStream.putNextEntry(zipEntry);
        
        int length = 0;
        // 4 KB�� �о buffer �迭�� ������ ���� ����Ʈ���� length�� ����
        while((length = in.read(buffer)) > 0) {
          zipOutputStream.write(buffer, 0, length); // ����� ����, ���뿡���� ���� ��ġ, ����� ����
          
        }
        zipOutputStream.closeEntry();
        in.close();
      }
      zipOutputStream.close();
      
      File file = new File(zip_filename);
      
      if (file.exists() && file.length() > 0) {
        System.out.println(zip_filename + " ���� �Ϸ�");
      }
      
//      if (file.delete() == true) {
//        System.out.println(zip_filename + " ������ �����߽��ϴ�.");
//      }
 
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }
 
    // download ���� ����
    mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);    
    
    return mav;
  }
  
  @RequestMapping(value = "/pdatfile/delete_by_pdcontentsno.do", 
      method = RequestMethod.POST)
  public ModelAndView delete_by_pdcontentsno(RedirectAttributes ra,
                                                              int pdcontentsno,
                                                              int productcateno
                                                            /*  int nowPage*/) {
    ModelAndView mav = new ModelAndView();

    int count = pdatfileProc.delete_by_pdcontentsno(pdcontentsno);

    ra.addAttribute("count", count); // ������ ���ڵ� ����
    ra.addAttribute("pdcontentsno", pdcontentsno);
    ra.addAttribute("productcateno", productcateno);
  //  ra.addAttribute("nowPage", nowPage);

    mav.setViewName("redirect:/pdatfile/delete_by_pdcontentsno_msg.jsp");

    return mav;
  }
}
