package dev.mvc.pdcontents;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface PdcontentsProcInter {
  
  // ��ǰ ���
  public int create(PdcontentsVO pdcontentsVO);
  
  // ��ǰ ���
  public List<PdcontentsVO> list_all();
  
  // productcateno�� ��ü ���
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
   * ������ ��� ���ڿ� ���� Box ���� 
   * @param listFile ��� ���ϸ� 
   * @param categrpno ī�װ���ȣ
   * @param search_count �˻� ����
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param word �˻���
   * @return
   */
  public String pagingBox(String listFile, int categrpno, int search_count, int nowPage, String word);
  
  /**
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public ArrayList<PdcontentsVO> list_by_productcateno_search_paging(HashMap<String, Object> map);
}


