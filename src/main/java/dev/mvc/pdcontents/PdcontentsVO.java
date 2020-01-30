package dev.mvc.pdcontents;

import org.springframework.web.multipart.MultipartFile;

public class PdcontentsVO {

  /** 상품번호 */
  private Integer pdcontentsno;
  
  /** 회원 번호 */
  private int memberno;
  
  /** 상품 카테고리 번호 */
  private int productcateno;
  
  private int pdthumbno;
  
  /** 상품명 */
  private String title;
  
  private int price;
  
  /** 내용 */
  private String content;
  
  /** 추천 */
  private int recom;
  
  /** 조회수 */
  private int cnt;
  
  /** 댓글수 */
  private int replycnt;
  
  /** 등록일 */
  private String rdate;
  
  /** 검색어 */
  private String word;

  private String fname;
  private String fupname;
  private String thumb;
  private long fsize;
  
  /** Form의 파일을 MultipartFile로 변환하여 저장  */
  private MultipartFile fnameMF;
  
  public int getPdcontentsno() {
    return pdcontentsno;
  }

  public void setPdcontentsno(Integer pdcontentsno) {
    this.pdcontentsno = pdcontentsno;
  }

  public int getMemberno() {
    return memberno;
  }

  public void setMemberno(int memberno) {
    this.memberno = memberno;
  }

  public int getPrice() {
    return price;
  }

  public void setPrice(int price) {
    this.price = price;
  }

  public int getPdthumbno() {
    return pdthumbno;
  }

  public void setPdthumbno(int pdthumbno) {
    this.pdthumbno = pdthumbno;
  }

  public int getProductcateno() {
    return productcateno;
  }

  public void setProductcateno(int productcateno) {
    this.productcateno = productcateno;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public int getRecom() {
    return recom;
  }

  public void setRecom(int recom) {
    this.recom = recom;
  }

  public int getCnt() {
    return cnt;
  }

  public void setCnt(int cnt) {
    this.cnt = cnt;
  }

  public int getReplycnt() {
    return replycnt;
  }

  public void setReplycnt(int replycnt) {
    this.replycnt = replycnt;
  }

  public String getRdate() {
    return rdate;
  }

  public void setRdate(String rdate) {
    this.rdate = rdate;
  }

  public String getWord() {
    return word;
  }

  public void setWord(String word) {
    this.word = word;
  }

  public String getFname() {
    return fname;
  }

  public void setFname(String fname) {
    this.fname = fname;
  }

  public String getFupname() {
    return fupname;
  }

  public void setFupname(String fupname) {
    this.fupname = fupname;
  }

  public String getThumb() {
    return thumb;
  }

  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

  public long getFsize() {
    return fsize;
  }

  public void setFsize(long fsize) {
    this.fsize = fsize;
  }

  public MultipartFile getFnameMF() {
    return fnameMF;
  }

  public void setFnameMF(MultipartFile fnameMF) {
    this.fnameMF = fnameMF;
  }
  
  
}







