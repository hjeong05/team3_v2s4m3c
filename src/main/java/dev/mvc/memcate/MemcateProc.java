package dev.mvc.memcate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.memcate.MemcateProc")
public class MemcateProc implements MemcateProcInter {
  
  @Autowired
  private MemcateDAOInter memcateDAO;
  
  @Override
  public int create(MemcateVO memcateVO) {
    int count = memcateDAO.create(memcateVO);
    return count;
  }

  
  @Override
  public List<MemcateVO> list_seqno_asc() {
    List<MemcateVO> list = memcateDAO.list_seqno_asc();
    return list;
  }

  @Override
  public int update(MemcateVO memcateVO) {
    int count = memcateDAO.update(memcateVO);
    return count;
  }

  @Override
  public MemcateVO read(int memccateno) {
    MemcateVO memcateVO = memcateDAO.read(memccateno);
    return memcateVO;
  }

  @Override
  public int delete(int memcateno) {
    int count = memcateDAO.delete(memcateno);
    return count;
  }


  @Override
  public int increaseCnt(int categrpno) {
    int count = memcateDAO.increaseCnt(categrpno);
    return count;
  }


  @Override
  public int decreaseCnt(int categrpno) {
    int count = memcateDAO.decreaseCnt(categrpno);
    return count;
  }


  @Override
  public int update_seqno_up(int memcateno) {
    int count = memcateDAO.update_seqno_up(memcateno);
    return count;
  }


  @Override
  public int update_seqno_down(int memcateno) {
    int count = memcateDAO.update_seqno_down(memcateno);
    return count;
  }


  @Override
  public int cnt_zero(int memcateno) {
    int count = memcateDAO.cnt_zero(memcateno);
    return count;
  }
  
  



}
