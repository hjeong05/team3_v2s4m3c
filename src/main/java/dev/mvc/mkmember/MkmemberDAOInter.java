package dev.mvc.mkmember;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MkmemberDAOInter {
  
  /**
   * 아이디 중복 검사
   * @param id 아이디
   * @return 중복 아이디 갯수
   */
  public int checkId(String id);
  
  /**
  * 회원가입
  * @param memberVO
  * @return 등록된 회원수 1 or 0
  */
  public int create(MkmemberVO mkmemberVO);
  
  /**
   * 등급별 회원 목록
   * @param memcateno
   * @return
   */
  public List<MkmemberVO> list_by_memcateno(int memcateno);
  
  /**
   * 전체 회원 목록
   * @return
   */
  public List<MkmemberVO> list_all();
  
  /**
   * 회원 정보 조회(memberno 기준)
   * @param memberno
   * @return
   */
  public MkmemberVO read(int memberno);
  
  /**
   * 회원 정보 조회(id 기준)
   * @param id
   * @return
   */
  public MkmemberVO readById(String id);
  
  /**
   * 회원 정보 수정
   * @param mkmemberVO
   * @return
   */
  public int update(MkmemberVO mkmemberVO);
  
  /**
   * 패스워드 검사
   * @param map
   * @return
   */
  public int passwd_check(HashMap<Object, Object> map);
  
  /**
   * 패스워드 변경
   * @param map
   * @return
   */
  public int passwd_update(HashMap<Object, Object> map);
  
  /**
   * 특정 회원 삭제
   * @param memberno
   * @return
   */
  public int delete(int memberno);
  
  /**
   * 등급별 회원수
   * @param memcateno
   * @return
   */
  public int count_by_memcateno(int memcateno);
  
  /**
   * 등급별 회원 삭제
   * @param memcateno
   * @return
   */
  public int delete_by_memcateno(int memcateno);
  
  /**
   * 로그인
   * @param map
   * @return
   */
  public int login(Map<Object, Object> map);

  /**
   * 회원 등급 변경
   * @param map
   * @return
   */
  public int grade_update(HashMap<Object, Object> map);
  
}
