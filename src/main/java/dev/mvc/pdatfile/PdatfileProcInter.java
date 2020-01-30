package dev.mvc.pdatfile;

import java.util.List;

public interface PdatfileProcInter {

  /**
   * ���� ���
   * @param pdatfileVO
   * @return
   */
  public int create(PdatfileVO pdatfileVO);
  
  /**
   * ���� ���
   * @return
   */
  public List<PdatfileVO> list();
  
  /**
   * pdcontentsno�� ÷�� ���� ���
   * @param pdcontentsno
   * @return
   */
  public List<PdatfileVO> list_by_pdcontentsno(int pdcontentsno);
  
  public int count_by_pdcontentsno(int pdcontentsno);
  
  public int delete_by_pdcontentsno(int pdcontentsno);
  
  /**
   *  1���� ���� ��ȸ
   * @param pdatfileno
   * @return
   */
  public PdatfileVO read(int pdatfileno);
  
  public int delete(int pdatfileno); 
}
