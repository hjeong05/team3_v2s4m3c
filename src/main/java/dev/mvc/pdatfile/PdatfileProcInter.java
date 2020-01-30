package dev.mvc.pdatfile;

import java.util.List;

public interface PdatfileProcInter {

  /**
   * 파일 등록
   * @param pdatfileVO
   * @return
   */
  public int create(PdatfileVO pdatfileVO);
  
  /**
   * 파일 목록
   * @return
   */
  public List<PdatfileVO> list();
  
  /**
   * pdcontentsno별 첨부 파일 목록
   * @param pdcontentsno
   * @return
   */
  public List<PdatfileVO> list_by_pdcontentsno(int pdcontentsno);
  
  public int count_by_pdcontentsno(int pdcontentsno);
  
  public int delete_by_pdcontentsno(int pdcontentsno);
  
  /**
   *  1건의 파일 조회
   * @param pdatfileno
   * @return
   */
  public PdatfileVO read(int pdatfileno);
  
  public int delete(int pdatfileno); 
}
