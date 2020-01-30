package dev.mvc.pdreply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import dev.mvc.pdreply.PdreplyMemberVO;
import dev.mvc.pdreply.PdreplyVO;
import nation.web.tool.Tool;

@Component("dev.mvc.pdreply.PdreplyProc")
public class PdreplyProc implements PdreplyProcInter {
  @Autowired
  private PdreplyDAOInter pdreplyDAO;
  
  public PdreplyProc(){
    System.out.println("--> PdreplyProc created.");
  }

  @Override
  public int create(PdreplyVO pdreplyVO) {
    int count = pdreplyDAO.create(pdreplyVO);
    return count;
  }

  @Override
  public List<PdreplyVO> list() {
    List<PdreplyVO> list = pdreplyDAO.list();
    return list;
  }

  @Override
  public List<PdreplyVO> list_by_pdcontentsno(int pdcontentsno) {
    List<PdreplyVO> list = pdreplyDAO.list_by_pdcontentsno(pdcontentsno);
    String content = "";
    
    // 특수 문자 변경
    for (PdreplyVO pdreplyVO:list) {
      content = pdreplyVO.getContent();
      content = Tool.convertChar(content);
      pdreplyVO.setContent(content);
    }
    return list;

  }

  @Override
  public List<PdreplyMemberVO> list_by_pdcontentsno_join(int pdcontentsno) {
    List<PdreplyMemberVO> list = pdreplyDAO.list_by_pdcontentsno_join(pdcontentsno);
    String content= "";
    
    // 특수 문자 변경
    for (PdreplyMemberVO pdreplyVO:list) {
      content = pdreplyVO.getContent();
      content = Tool.convertChar(content);
      pdreplyVO.setContent(content);
    }
    return list;
  }

  // 댓글 개수 확인 
  @Override
  public int reply_cnt() {
    int count = pdreplyDAO.reply_cnt();
    return count;
  }

  /**
   * 댓글 삭제
   */
  @Override
  public int delete(int pdreplyno) {
    int count = pdreplyDAO.delete(pdreplyno);
    return count;
  }

  /**
   * 댓글 삭제시 패스워드 확인
   */
  @Override
  public int checkPasswd(Map map) {
    int count = pdreplyDAO.checkPasswd(map);
    return count;
  }

}