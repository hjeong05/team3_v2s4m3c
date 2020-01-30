package dev.mvc.pdreply;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.pdcontents.PdcontentsProcInter;

@Controller
public class PdreplyCont {
  @Autowired
  @Qualifier("dev.mvc.pdreply.PdreplyProc")
  private PdreplyProcInter pdreplyProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.pdcontents.PdcontentsProc")
  private PdcontentsProcInter pdcontentsProc;
  
  public PdreplyCont(){
    System.out.println("--> PdreplyCont created.");
  }
  
  /**
   * ´ñ±Û µî·Ï
   * @param pdreplyVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/pdreply/create.do",
                            method = RequestMethod.POST,
                            produces = "text/plain;charset=UTF-8")
  public String create_reply(PdreplyVO pdreplyVO) {
    int count = pdreplyProc.create(pdreplyVO);
    
    JSONObject obj = new JSONObject();
    obj.put("count", count);
    
    // ´ñ±Û µî·Ï ½Ã ´ñ±Û ¼ö Áõ°¡ 
    pdcontentsProc.increaseReplycnt(pdreplyVO.getPdcontentsno());
    
    return obj.toString(); // {"count":1}
    
  }
  
  /**
   * ´ñ±Û ¸ñ·Ï
   * @param session
   * @return
   */
  @RequestMapping(value = "/pdreply/list.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {
    ModelAndView mav = new ModelAndView();

    if(adminProc.isAdmin(session)) {
      List<PdreplyVO> list = pdreplyProc.list();
      mav.addObject("list", list);
      mav.setViewName("/pdreply/list"); // /webapp/reply/list.jsp
    } else {
      mav.setViewName("redirect/admin/login_need.jsp");  //  /webapp/admin/login_need.jsp
    }
    return mav;
  }

  /**
   * ´ñ±Û »óÇ°º° ¸ñ·Ï 
   * @param contentsno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/pdreply/list_by_pdcontentsno.do",
                            method = RequestMethod.GET,
                            produces = "text/plain;charset=UTF-8")
  public String list_by_contentsno(int pdcontentsno) {
    List<PdreplyVO> list = pdreplyProc.list_by_pdcontentsno(pdcontentsno);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
    
    return obj.toString(); // {"count":1}
    
  }
  
  /**
   * ´ñ±Û ¸®½ºÆ® Á¶ÀÎ
   * @param contentsno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/pdreply/list_by_pdcontentsno_join.do",
                            method = RequestMethod.GET,
                            produces = "text/plain;charset=UTF-8")
  public String list_by_contentsno_join(int pdcontentsno) {
    // String msg="JSON Ãâ·Â";
    // return msg;
    
    List<PdreplyMemberVO> list = pdreplyProc.list_by_pdcontentsno_join(pdcontentsno);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
    
    return obj.toString(); 
    
  }
}