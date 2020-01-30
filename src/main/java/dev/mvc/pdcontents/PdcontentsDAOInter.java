package dev.mvc.pdcontents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;



public interface PdcontentsDAOInter {

  /**
   * ��ǰ ���
   * @param pdcontentsVO
   * @return
   */
  public int create(PdcontentsVO pdcontentsVO);
  
  /**
   * ��ü ���
   * @return
   */
  public List<PdcontentsVO> list_all();
  
  /**
   * productcateno�� ��ü ���
   * @param productcateno
   * @return
   */
  public List<PdcontentsVO> list_by_productcateno(int productcateno);

  /**
   * ��ü ��� ���ڵ� ����
   * @return ��ü ��� ���ڵ� ����
   */
  public int total_count();

  /**
   * ��ȸ
   * @param pdcontentsno
   * @return
   */
  public PdcontentsVO read(int pdcontentsno);
  
  /**
   * ����
   * @param pdcontentsVO
   * @return ������ ���ڵ� ���� 
   */
  public int update(PdcontentsVO pdcontentsVO);
  
  /**
   * ����� ���� 
   * @param pdcontentsVO
   * @return
   */
  public int update_thumb(PdcontentsVO pdcontentsVO);
  
  /**
   * �Ѱ� ���� 
   * @param pdcontentsno
   * @return
   */
  public int delete(int pdcontentsno);
  
  /**
   * �θ� ī�װ� ��ȣ�� ���ڵ� ����
   * @param productcateno
   * @return
   */
  public int delete_by_productcateno(int productcateno);
  
  /**
   * ��� �� ����
   * @param pdcontentsno
   * @return
   */
  public int increaseReplycnt(int pdcontentsno);
  
  /**
   * ��� �� ����
   * @param pdcontentsno
   * @return
   */
  public int decreaseReplycnt(int pdcontentsno);
  
  
  /**
   * �˻��� ã�� ���
   * @param hashMap
   * @return
   */
  public List<PdcontentsVO> list_by_productcateno_search(HashMap<String,Object>hashMap);
  
  /**
   * ī�װ��� �˻� ���ڵ� ����
   * @param map
   * @return
   */
  public int search_count(HashMap<String,Object> hashMap);
  
  /**
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public ArrayList<PdcontentsVO> list_by_productcateno_search_paging(HashMap<String, Object> map);
  
}




