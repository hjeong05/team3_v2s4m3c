package dev.mvc.pdreply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface PdreplyDAOInter {
  /**
   * 등록
   * @param replyVO
   * @return
   */
  public int create(PdreplyVO pdreplyVO);
  
  /**
   * 전체 목록
   * @return
   */
  public List<PdreplyVO> list();
 
  /**
   * 상품 별 댓글 목록
   * @param pdcontentsno
   * @return
   */
  public List<PdreplyVO> list_by_pdcontentsno(int pdcontentsno);

  /**
   * 상품 내 멤버 별 댓글 목록
   * @param pdcontentsno
   * @return
   */
  public List<PdreplyMemberVO> list_by_pdcontentsno_join(int pdcontentsno);
  
  /**
   * 삭제용 패스워드 검사
   * @param map
   * @return
   */
  public int checkPasswd(Map map);
  
  /**
   * 댓글 개수
   * @return
   */
  public int reply_cnt();
  
  /**
   * 댓글 삭제 
   * @param pdreplyno
   * @return
   */
  public int delete(int pdreplyno);

  
}