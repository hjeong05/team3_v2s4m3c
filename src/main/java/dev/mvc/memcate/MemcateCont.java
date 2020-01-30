package dev.mvc.memcate;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.mkmember.MkmemberProcInter;

@Controller
public class MemcateCont {
  @Autowired
  @Qualifier("dev.mvc.memcate.MemcateProc")
  private MemcateProcInter memcateProc;
  
  @Autowired
  @Qualifier("dev.mvc.mkmember.MkmemberProc")
  private MkmemberProcInter mkmemberProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") // 이름 지정
  private AdminProcInter adminProc;
  
  public MemcateCont() {
    System.out.println("--> MemcateCont created.");
  }
  
  // http://localhost:9090/team3/memcate/create.do
  // 등록 폼
  @RequestMapping(value="/memcate/create.do", method=RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/memcate/create"); // /webapp/memcate/create.jsp
    
    return mav;
  }
  
  // 등록 처리
  @RequestMapping(value="/memcate/create.do", method=RequestMethod.POST)
  public ModelAndView create(MemcateVO memcateVO) {
    ModelAndView mav = new ModelAndView();
    
    int count = memcateProc.create(memcateVO);

    if (count == 0) {
      mav.setViewName("redirect:/memcate/create_msg.jsp?count=" + count);
    } else {
      mav.setViewName("redirect:/memcate/list.do"); // list.jsp X
    }
        
    return mav;
  }
  
  // seqno 오름차순 목록
  @RequestMapping(value="/memcate/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (adminProc.isAdmin(session)) { // 관리자 로그인인 경우
      List<MemcateVO> list = memcateProc.list_seqno_asc();
      
      mav.addObject("list", list);
      mav.setViewName("/memcate/list");   
    } else {
      mav.setViewName("/admin/login_need"); // /webapp/admin/login_need.jsp    
    }
    
    return mav;
  }
  
  // 수정폼 + 조회
  @RequestMapping(value="/memcate/update.do", method=RequestMethod.GET)
  public ModelAndView update(int memcateno) {
    ModelAndView mav = new ModelAndView();
    
    MemcateVO memcateVO = memcateProc.read(memcateno);
    
    mav.addObject("memcateVO", memcateVO);
    mav.setViewName("/memcate/update"); // /webapp/memcate/update.jsp

    // mav.setViewName("redirect:/memcate/create_msg.jsp?count=" + count);
        
    return mav;
  }
 
  // 수정 처리
  @RequestMapping(value="/memcate/update.do", method=RequestMethod.POST)
  public ModelAndView update(MemcateVO memcateVO) {
    ModelAndView mav = new ModelAndView();
    
    int count = memcateProc.update(memcateVO);
    String url = "redirect:/memcate/update_msg.jsp?count=" + count +
                      "&memcateno=" + memcateVO.getMemcateno();
    mav.setViewName(url);
                               
    return mav;
  }
  
  // 삭제폼
  @RequestMapping(value="/memcate/delete.do", method=RequestMethod.GET)
  public ModelAndView delete(int memcateno) {
    ModelAndView mav = new ModelAndView();
    
    MemcateVO memcateVO = memcateProc.read(memcateno);
    
    int count_by_memcateno = mkmemberProc.count_by_memcateno(memcateno);
    mav.addObject("count_by_memcateno", count_by_memcateno);
    
    mav.addObject("memcateVO", memcateVO);
    mav.setViewName("/memcate/delete"); 
        
    return mav;
  }
  
  // 삭제 처리
  @RequestMapping(value="/memcate/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_proc(int memcateno) {
    ModelAndView mav = new ModelAndView();
    
    int count = memcateProc.delete(memcateno);
    String url = "redirect:/memcate/delete_msg.jsp?count=" + count +
                      "&memcateno=" + memcateno;
    mav.setViewName(url);
                               
    return mav;
  }
  
  // 순서 up
  @RequestMapping(value="/memcate/update_seqno_up.do", 
                             method=RequestMethod.GET)
  public ModelAndView update_seqno_up(int memcateno) {
    ModelAndView mav = new ModelAndView();
    
    memcateProc.update_seqno_up(memcateno);
    String url = "redirect:/memcate/list.do";
    mav.setViewName(url);
                               
    return mav;
  }
  
  // 순서 down
  @RequestMapping(value="/memcate/update_seqno_down.do", 
                             method=RequestMethod.GET)
  public ModelAndView update_seqno_down(int memcateno) {
    ModelAndView mav = new ModelAndView();
    
    memcateProc.update_seqno_down(memcateno);
    String url = "redirect:/memcate/list.do";
    mav.setViewName(url);
                               
    return mav;
  }
  
}
