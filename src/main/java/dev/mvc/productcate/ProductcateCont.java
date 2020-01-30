package dev.mvc.productcate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.pdcontents.PdcontentsProcInter;
import dev.mvc.productcate.ProductcateVO;

@Controller
public class ProductcateCont {
  @Autowired
  @Qualifier("dev.mvc.productcate.ProductcateProc")
  private ProductcateProcInter productcateProc;
  
  @Autowired
  @Qualifier("dev.mvc.pdcontents.PdcontentsProc")
  private PdcontentsProcInter pdcontentsProc;
  
  public ProductcateCont() {
    System.out.println("--> ProductcateCont created");
  }
  
  @RequestMapping(value="/productcate/list.do", method =RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<ProductcateVO> list = productcateProc.list_seqno_asc();
    
    mav.addObject("list", list);     
    mav.setViewName("/productcate/list"); 
    
    return mav;
  }
  
  // http://localhost:9090/ojt/categrp/create.do
  @RequestMapping(value = "/productcate/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/productcate/create"); // /webapp/productcate/create.jsp
    
    return mav;
  }

  // 등록 처리
  @RequestMapping(value = "/productcate/create.do", method = RequestMethod.POST)
  public ModelAndView create(ProductcateVO productcateVO) {
    ModelAndView mav = new ModelAndView();
  
    int count = productcateProc.create(productcateVO);
    
    if(count==0) {
      mav.setViewName("redirect:/productcate/create_msg.jsp?count="+count);
    }else {
      mav.setViewName("redirect:/productcate/list.do"); //list.jsp X
    }
    return mav;
  }
  
  //수정폼 + 조회
  @RequestMapping(value = "/productcate/update.do", method = RequestMethod.GET)
  public ModelAndView update(int productcateno) {
    ModelAndView mav = new ModelAndView();
  
    ProductcateVO productcateVO = productcateProc.read(productcateno);
   
    mav.addObject("productcateVO", productcateVO);
    mav.setViewName("/productcate/update"); // /webapp/categrp/create_msg.jsp
    
    //mav.setViewName("redirect:/categrp/create_msg.jsp?count="+count);
    return mav;
  }
  
  //수정 처리
  @RequestMapping(value = "/productcate/update.do", method = RequestMethod.POST)
  public ModelAndView update(ProductcateVO productcateVO) {
    ModelAndView mav = new ModelAndView();
  
    int count = productcateProc.update(productcateVO);
    // String url = "redirect:/categrp/update_msg.jsp?count="
    mav.setViewName("redirect:/productcate/update_msg.jsp?count="+
                            count + "&productcateno="+productcateVO.getProductcateno());
    return mav;
  }
  
  //삭제 폼
  @RequestMapping(value = "/productcate/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int productcateno) {
    ModelAndView mav = new ModelAndView();
  
    ProductcateVO productcateVO = productcateProc.read(productcateno);
        
    // int count_by_productcateno = contentsProc.count_by_categrpno(productcateno);
    // mav.addObject("count_by_categrpno", count_by_categrpno);
    
      mav.addObject("productcateVO", productcateVO);
      mav.setViewName("/productcate/delete"); // /webapp/categrp/create_msg.jsp
    
     return mav;
  }
  
  //삭제처리
  @RequestMapping(value = "/productcate/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(int productcateno) {
    ModelAndView mav = new ModelAndView();
  
    int count = productcateProc.delete(productcateno);
    String url = "redirect:/productcate/delete_msg.jsp?count="+count 
                     + "&productcateno="+productcateno;
    mav.setViewName(url);
    return mav;
  }
  
  @RequestMapping(value="/productcate/list_for_user.do", method=RequestMethod.GET)
  public ModelAndView list_for_user() {
    ModelAndView mav = new ModelAndView();
    
    List<ProductcateVO> list = productcateProc.list_seqno_asc();
    
    mav.addObject("list", list);
    
    int total_count = pdcontentsProc.total_count();
    
    mav.addObject("total_count", total_count);
    mav.setViewName("/productcate/list_for_user"); // /webapp/categrp/list.jsp

    // mav.setViewName("redirect:/categrp/create_msg.jsp?count=" + count);
        
    return mav;
  }
}
