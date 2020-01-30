package dev.mvc.pdatfile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.pdatfile.PdatfileProc")
public class PdatfileProc implements PdatfileProcInter {
  @Autowired
  private PdatfileDAOInter pdatfileDAO;
  
  @Override
  public int create(PdatfileVO pdatfileVO) {
    int count = pdatfileDAO.create(pdatfileVO);
    return count;
  }

  @Override
  public List<PdatfileVO> list() {
    List<PdatfileVO> list = pdatfileDAO.list();
    return list;
  }

  @Override
  public List<PdatfileVO> list_by_pdcontentsno(int pdcontentsno) {
    List<PdatfileVO> list = pdatfileDAO.list_by_pdcontentsno(pdcontentsno);
    return list;
  }

  @Override
  public int count_by_pdcontentsno(int pdcontentsno) {
    int count = pdatfileDAO.count_by_pdcontentsno(pdcontentsno);
    return count;
  }

  @Override
  public int delete_by_pdcontentsno(int pdcontentsno) {
    int count = pdatfileDAO.delete_by_pdcontentsno(pdcontentsno);
    return count;
  }

  @Override
  public PdatfileVO read(int pdatfileno) {
    PdatfileVO pdatfileVO = pdatfileDAO.read(pdatfileno);
    return pdatfileVO;
  }

  @Override
  public int delete(int pdatfileno) {
    int count = pdatfileDAO.delete(pdatfileno);
    return count;
  }

}
