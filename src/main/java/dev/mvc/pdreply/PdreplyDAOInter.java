package dev.mvc.pdreply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface PdreplyDAOInter {
  /**
   * ���
   * @param replyVO
   * @return
   */
  public int create(PdreplyVO pdreplyVO);
  
  /**
   * ��ü ���
   * @return
   */
  public List<PdreplyVO> list();
 
  /**
   * ��ǰ �� ��� ���
   * @param pdcontentsno
   * @return
   */
  public List<PdreplyVO> list_by_pdcontentsno(int pdcontentsno);

  /**
   * ��ǰ �� ��� �� ��� ���
   * @param pdcontentsno
   * @return
   */
  public List<PdreplyMemberVO> list_by_pdcontentsno_join(int pdcontentsno);
  
  /**
   * ������ �н����� �˻�
   * @param map
   * @return
   */
  public int checkPasswd(Map map);
  
  /**
   * ��� ����
   * @return
   */
  public int reply_cnt();
  
  /**
   * ��� ���� 
   * @param pdreplyno
   * @return
   */
  public int delete(int pdreplyno);

  
}