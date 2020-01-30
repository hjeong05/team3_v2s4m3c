package dev.mvc.productcate;

import java.util.List;

import dev.mvc.productcate.ProductcateVO;

public interface ProductcateDAOInter {

  /**
   * 목록
   * <xmp>
   * <select id="list_prodcutcateno_asc" resultType="ProductcateVO">
   * </xmp> 
   * @return
   */
  public List<ProductcateVO> list_seqno_asc();
  
  /**
   * <xmp>
   * 등록
   * <insert id="create" parameterType="ProductcateVO">
   * </xmp>
   * @param productcateVO
   * @return
   */
  public int create(ProductcateVO productcateVO);
  
  /**
   * 조회
   * @param productcateno
   * @return
   */
  public ProductcateVO read(int productcateno);

  
  /**
   * <xmp>
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp>
   * @param productcateno
   * @return
   */
  public int delete(int productcateno);
  
  /**
   * 수정 
   * @param productcateVO
   * @return
   */
  public int update(ProductcateVO productcateVO);
  
  /**
   * 그룹에 속한 컨텐츠 글 수 증가
   * @param productcateno
   * @return
   */
  public int increaseCnt(int productcateno);
  
  /**
   * 그룹에 속한 컨텐츠 글 수 감소
   * @param productcateno
   * @return
   */
  public int decreaseCnt(int productcateno);
  
  public int cnt_zero(int categrpno);
  
  
}
