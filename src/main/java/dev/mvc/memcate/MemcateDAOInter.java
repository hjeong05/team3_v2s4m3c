package dev.mvc.memcate;

import java.util.List;

public interface MemcateDAOInter {
  
  /**
   *  등록
   * @param memcateVO
   * @return
   */
  public int create(MemcateVO memcateVO);
  
  /**
   * 목록
   * @return
   */
  public List<MemcateVO> list_seqno_asc();
  
  /**
   * 조회
   * @param memccateno
   * @return
   */
  public MemcateVO read(int memccateno);
  
  /**
   * 수정
   * @param memcateVO
   * @return
   */
  public int update(MemcateVO memcateVO);
  
  /**
   * 삭제
   * @param categrpno
   * @return
   */
  public int delete(int memcateno);
  
  /**
   * 회원 수 증가
   * @param categrpno
   * @return
   */
  public int increaseCnt(int categrpno);
  
  /**
   * 회원 수 감소
   * @param categrpno
   * @return
   */
  public int decreaseCnt(int categrpno);
  
  /**
   * 순서 up
   * @param memcateno
   * @return
   */
  public int update_seqno_up(int memcateno);
  
  /**
   * 순서 down
   * @param memcateno
   * @return
   */
  public int update_seqno_down(int memcateno);
  
  /**
   * 회원수 초기화(0명)
   * @param memcateno
   * @return
   */
  public int cnt_zero(int memcateno);

  
}
