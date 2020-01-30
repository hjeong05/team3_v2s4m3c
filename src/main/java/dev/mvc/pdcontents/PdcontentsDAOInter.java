package dev.mvc.pdcontents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;



public interface PdcontentsDAOInter {

  /**
   * 상품 등록
   * @param pdcontentsVO
   * @return
   */
  public int create(PdcontentsVO pdcontentsVO);
  
  /**
   * 전체 목록
   * @return
   */
  public List<PdcontentsVO> list_all();
  
  /**
   * productcateno별 전체 목록
   * @param productcateno
   * @return
   */
  public List<PdcontentsVO> list_by_productcateno(int productcateno);

  /**
   * 전체 등록 레코드 갯수
   * @return 전체 등록 레코드 갯수
   */
  public int total_count();

  /**
   * 조회
   * @param pdcontentsno
   * @return
   */
  public PdcontentsVO read(int pdcontentsno);
  
  /**
   * 수정
   * @param pdcontentsVO
   * @return 수정된 레코드 갯수 
   */
  public int update(PdcontentsVO pdcontentsVO);
  
  /**
   * 썸네일 수정 
   * @param pdcontentsVO
   * @return
   */
  public int update_thumb(PdcontentsVO pdcontentsVO);
  
  /**
   * 한건 삭제 
   * @param pdcontentsno
   * @return
   */
  public int delete(int pdcontentsno);
  
  /**
   * 부모 카테고리 번호별 레코드 삭제
   * @param productcateno
   * @return
   */
  public int delete_by_productcateno(int productcateno);
  
  /**
   * 댓글 수 증가
   * @param pdcontentsno
   * @return
   */
  public int increaseReplycnt(int pdcontentsno);
  
  /**
   * 댓글 수 감소
   * @param pdcontentsno
   * @return
   */
  public int decreaseReplycnt(int pdcontentsno);
  
  
  /**
   * 검색어 찾기 목록
   * @param hashMap
   * @return
   */
  public List<PdcontentsVO> list_by_productcateno_search(HashMap<String,Object>hashMap);
  
  /**
   * 카테고리별 검색 레코드 개수
   * @param map
   * @return
   */
  public int search_count(HashMap<String,Object> hashMap);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public ArrayList<PdcontentsVO> list_by_productcateno_search_paging(HashMap<String, Object> map);
  
}




