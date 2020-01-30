package dev.mvc.productcate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.productcate.ProductcateVO;

@Component("dev.mvc.productcate.ProductcateProc")
public class ProductcateProc implements ProductcateProcInter{
  @Autowired
  ProductcateDAOInter productcateDAO;

  @Override
  public List<ProductcateVO> list_seqno_asc() {
    List<ProductcateVO> list = productcateDAO.list_seqno_asc(); 
    return list;
  }

  
  @Override
  public int create(ProductcateVO productcateVO) {
    int count = productcateDAO.create(productcateVO);
    return count;
  }

  @Override
  public ProductcateVO read(int productcateno) {
    ProductcateVO productcateVO = productcateDAO.read(productcateno);
    return productcateVO;
  }
  
  @Override
  public int delete(int productcateno) {
    int count = productcateDAO.delete(productcateno);
    return count;
  }

  @Override
  public int update(ProductcateVO productcateVO) {
    int count = productcateDAO.update(productcateVO);
    return count;
  }

  @Override
  public int increaseCnt(int productcateno) {
    int count = productcateDAO.increaseCnt(productcateno);
    return count;
  }

  @Override
  public int decreaseCnt(int productcateno) {
    int count = productcateDAO.decreaseCnt(productcateno);
    return count;
  }

  @Override
  public int cnt_zero(int categrpno) {
    int count = productcateDAO.cnt_zero(categrpno);
    return count;
  }

}
