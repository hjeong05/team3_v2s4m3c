package dev.mvc.mkmember;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.mkmember.MkmemberProc")
public class MkmemberProc implements MkmemberProcInter {
  @Autowired
  private MkmemberDAOInter mkmemberDAO;

  @Override
  public int checkId(String id) {
    int count = mkmemberDAO.checkId(id);
    return count;
  }

  @Override
  public int create(MkmemberVO mkmemberVO) {
    int count = mkmemberDAO.create(mkmemberVO);
    return count;
  }

  @Override
  public List<MkmemberVO> list_by_memcateno(int memcateno) {
    List<MkmemberVO> list = mkmemberDAO.list_by_memcateno(memcateno);
    return list;
  }

  @Override
  public List<MkmemberVO> list_all() {
    List<MkmemberVO> list = mkmemberDAO.list_all();
    return list;
  }

  @Override
  public MkmemberVO read(int memberno) {
    MkmemberVO mkmemberVO = mkmemberDAO.read(memberno);
    return mkmemberVO;
  }

  @Override
  public MkmemberVO readById(String id) {
    MkmemberVO mkmemberVO = mkmemberDAO.readById(id);
    return mkmemberVO;
  }

  @Override
  public int update(MkmemberVO mkmemberVO) {
    int count = mkmemberDAO.update(mkmemberVO);
    return count;
  }

  @Override
  public int passwd_check(HashMap<Object, Object> map) {
    int count = mkmemberDAO.passwd_check(map);
    return count;
  }

  @Override
  public int passwd_update(HashMap<Object, Object> map) {
    int count = mkmemberDAO.passwd_update(map);
    return count;
  }

  @Override
  public int delete(int memberno) {
    int count = mkmemberDAO.delete(memberno);
    return count;
  }

  @Override
  public int count_by_memcateno(int memcateno) {
    int count = mkmemberDAO.count_by_memcateno(memcateno);
    return count;
  }

  @Override
  public int delete_by_memcateno(int memcateno) {
    int count = mkmemberDAO.delete_by_memcateno(memcateno);
    return count;
  }

  @Override
  public int login(Map<Object, Object> map) {
    int count = mkmemberDAO.login(map);
    return count;
  }

  @Override
  public int grade_update(HashMap<Object, Object> map) {
    int count = mkmemberDAO.grade_update(map);
    return count;
  }
  
  
  
}
