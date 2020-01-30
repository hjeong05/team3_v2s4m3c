package dev.mvc.pdcontents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.pdcontents.PdcontentsProc")
public class PdcontentsProc implements PdcontentsProcInter {
  @Autowired
  private PdcontentsDAOInter pdcontentsDAO;

  @Override
  public int create(PdcontentsVO pdcontentsVO) {
    int count = pdcontentsDAO.create(pdcontentsVO);
    return count;
  }

  @Override
  public List<PdcontentsVO> list_all() {
    List<PdcontentsVO> list = pdcontentsDAO.list_all();
    return list;
  }

  @Override
  public List<PdcontentsVO> list_by_productcateno(int productcateno) {
    List<PdcontentsVO> list = pdcontentsDAO.list_by_productcateno(productcateno);
    return list;
  }

  @Override
  public int total_count() {
    int count = pdcontentsDAO.total_count();
    return count;
  }

  @Override
  public PdcontentsVO read(int pdcontentsno) {
    PdcontentsVO pdcontentsVO = pdcontentsDAO.read(pdcontentsno);
    return pdcontentsVO;
  }

  @Override
  public int update(PdcontentsVO pdcontentsVO) {
    int count = pdcontentsDAO.update(pdcontentsVO);
    return count;
  }

  @Override
  public int update_thumb(PdcontentsVO pdcontentsVO) {
    int count = pdcontentsDAO.update_thumb(pdcontentsVO);
    return count;
  }

  @Override
  public int delete(int pdcontentsno) {
    int count = pdcontentsDAO.delete(pdcontentsno);
    return count;
  }
  @Override
  public int delete_by_productcateno(int productcateno) {
    int count = pdcontentsDAO.delete_by_productcateno(productcateno);
    return count;
  }

  @Override
  public List<PdcontentsVO> list_by_productcateno_search(HashMap<String, Object> hashMap) {
    List<PdcontentsVO> list = pdcontentsDAO.list_by_productcateno_search(hashMap);
    return null;
  }

  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int count = pdcontentsDAO.search_count(hashMap);
    return count;
  }

  // 댓글 수 증가
  @Override
  public int increaseReplycnt(int pdcontentsno) {
    int count = pdcontentsDAO.increaseReplycnt(pdcontentsno);
    return count;
  }

  // 댓글 수 감소
  @Override
  public int decreaseReplycnt(int pdcontentsno) {
    int count = pdcontentsDAO.decreaseReplycnt(pdcontentsno);
    return count;
  }

  /** 
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
  @Override
  public String pagingBox(String listFile, int productcateno, int search_count, int nowPage, String word){ 
     int totalPage = (int)(Math.ceil((double)search_count/Pdcontents.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Pdcontents.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Pdcontents.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Pdcontents.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Pdcontents.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
 
    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowGrp-1) * Pdcontents.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&productcateno="+productcateno+"'>이전</A></span>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='"+listFile+"?word="+word+"&nowPage="+i+"&productcateno="+productcateno+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowGrp * Pdcontents.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&word="+word+"&nowPage="+_nowPage+"&productcateno="+productcateno+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
  @Override
  public ArrayList<PdcontentsVO> list_by_productcateno_search_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Pdcontents.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Pdcontents.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<PdcontentsVO> list = pdcontentsDAO.list_by_productcateno_search_paging(map);
    
    return list;
  }
}



