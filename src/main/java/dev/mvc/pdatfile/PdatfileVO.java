package dev.mvc.pdatfile;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class PdatfileVO {
  private int pdatfileno;
  private int pdcontentsno;
  private String fname;
  private String fupname;
  private String thumb;
  private long fsize;
  private String rdate;
  
  /** Form의 파일을 MultipartFile로 변환하여 List에 저장  */
  private List<MultipartFile> fnamesMF;
  
  // private MultipartFile fnamesMF;  // 하나의 파일 처리
  /** 파일 단위 출력 */
  private String flabel;   
  
  public int getPdatfileno() {
    return pdatfileno;
  }
  public void setPdatfileno(int pdatfileno) {
    this.pdatfileno = pdatfileno;
  }
  public int getPdcontentsno() {
    return pdcontentsno;
  }
  public void setPdcontentsno(int pdcontentsno) {
    this.pdcontentsno = pdcontentsno;
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
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public List<MultipartFile> getFnamesMF() {
    return fnamesMF;
  }
  public void setFnamesMF(List<MultipartFile> fnamesMF) {
    this.fnamesMF = fnamesMF;
  }
  public String getFlabel() {
    return flabel;
  }
  public void setFlabel(String flabel) {
    this.flabel = flabel;
  }
  
}
