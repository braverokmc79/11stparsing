<%@page import="store.Categories11stVO"%>
<%@page import="store.PageMakerAndSearch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="store.ProductSearch11stVO"%>
<%@page import="java.util.List"%>
<%@page import="store.Api11stProductSearchParsing"%>
<%@ page import="java.text.*" %>
<%
	NumberFormat nf = NumberFormat.getNumberInstance();
%>
<%
	String keyword = request.getParameter("keyword");
	String pageNum = request.getParameter("pageNum");
	String pageSize = request.getParameter("pageSize");
	String sortCd = request.getParameter("sortCd");
	String option = request.getParameter("option");
	String categories =request.getParameter("categories");
	String targetSearchPrd = request.getParameter("targetSearchPrd");
	String categoryCode=request.getParameter("categoryCode");

	int totalCount=0;
	String paging=null;
	//현재 페이지 url
	StringBuffer currentURL=request.getRequestURL();
	
	Api11stProductSearchParsing api11st = Api11stProductSearchParsing.getInstance();	
	List<ProductSearch11stVO> productList = api11st.xmlParsingProductList(keyword, pageNum, pageSize, sortCd, option, categories,targetSearchPrd, categoryCode);

	if(productList!=null && productList.size() >0){
		PageMakerAndSearch pageMaker=new PageMakerAndSearch();
		
		if(pageNum!=null && !pageNum.equals("")){
			pageMaker.setPage(Integer.parseInt(pageNum));
		}
		
		if(pageSize!=null && !pageSize.equals("")){
			pageMaker.setPerPageNum(Integer.parseInt(pageSize));
		}
		totalCount=Integer.parseInt(productList.get(0).getTotalCount()); 		
		pageMaker.setKeyword(keyword);
		
		if(pageSize==null || pageSize.equals("")) {
			pageMaker.setPerPageNum(50);
		}else{
			pageMaker.setPerPageNum(Integer.parseInt(pageSize));
		}

		pageMaker.setSortCd(sortCd);
		pageMaker.setOption(option);
		pageMaker.setCategories(categories);
		pageMaker.setTargetSearchPrd(targetSearchPrd);		
		pageMaker.setTotalCount(totalCount);
		
		paging=pageMaker.bootStrapPagingSearchHTML(currentURL.toString()+"?");
	}
	
	List<Categories11stVO> categories11st=api11st.xmlParsingCategories11st();
	//System.out.println("카테고리 목록 :" + categories11st.size());
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>SPROUT</title>
</head>
<body>

	<%@ include file="common/menu.jsp"%>

	<div class="container">
		<div class="row">

			<form class="form-inline" id="searchFrm">
				<div class="form-group">
					<select name="categoryCode" class="form-control">
					   <option value=""  <%if(categoryCode==null||categoryCode.equals("")) out.print("selected");%> >카테고리 검색</option>
						<%
							for(Categories11stVO vo  : categories11st ){
						%>
							<option value="<%= vo.getCategoryPrdCnt() %>" <%if(categoryCode!=null&& categoryCode.equals(vo.getCategoryPrdCnt() )) out.print("selected");%> ><%= vo.getCategoryName() %></option>			
					 	<%								
							}
						
						%>
					</select>
					
				</div>
				<div class="form-group">
					<select name="pageSize" class="form-control">
						<option value="5"  <%if(pageSize!=null&&pageSize.equals("5")) out.print("selected");%> >5</option>
						<option value="10"  <%if(pageSize!=null&&pageSize.equals("10")) out.print("selected");%> >10</option>
						<option value="30"  <%if(pageSize!=null&&pageSize.equals("30")) out.print("selected");%> >30</option>
						<option value="50"  <%if(pageSize ==null ||pageSize.equals("50")) out.print("selected");%> >50</option>
						<option value="100"  <%if(pageSize!=null&&pageSize.equals("100")) out.print("selected");%> >100</option>
						<option value="150"  <%if(pageSize!=null&&pageSize.equals("150")) out.print("selected");%>>150</option>
						<option value="200"  <%if(pageSize!=null&&pageSize.equals("200")) out.print("selected");%> >200</option>
					</select>
				</div>				
				
<!-- 			sortCd	String	X	정렬순서
			    	→ CP : 인기도순
			    	→ A : 누적판매순
			    	→ G : 평가높은순
			    	→ I : 후기/리뷰많은순
			    	→ L : 낮은가격순
			    	→ H : 높은가격순
			    	→ N : 최근등록순 
	    	-->
				<div class="form-group">
					<select name="sortCd" class="form-control">
						<option value="X" <%if(sortCd!=null&&sortCd.equals("X")) out.print("selected");%> >정렬순서</option>
						<option value="CP" <%if(sortCd!=null&&sortCd.equals("CP")) out.print("selected");%> >인기도순</option>
						<option value="A" <%if(sortCd!=null&&sortCd.equals("A")) out.print("selected");%> >누적판매순</option>
						<option value="G" <%if(sortCd!=null&&sortCd.equals("G")) out.print("selected");%> >평가높은순</option>
						<option value="I" <%if(sortCd!=null&&sortCd.equals("I")) out.print("selected");%> >후기/리뷰많은순</option>
						<option value="L" <%if(sortCd!=null&&sortCd.equals("L")) out.print("selected");%> >낮은가격순</option>
						<option value="H <%if(sortCd!=null&&sortCd.equals("H")) out.print("selected");%> ">높은가격순</option>
						<option value="N" <%if(sortCd!=null&&sortCd.equals("N")) out.print("selected");%>  >최근등록순</option>
					</select>
				</div>
		
				<div class="form-group">
					<select name="targetSearchPrd" class="form-control">
						<option value="" <%if(targetSearchPrd==null||targetSearchPrd.equals("")) out.print("selected");%> >상품 검색 대상</option>
						<option value="KOR" <%if(targetSearchPrd!=null&&targetSearchPrd.equals("KOR")) out.print("selected");%> >국문상품</option>
						<option value="ENG" <%if(targetSearchPrd!=null&&targetSearchPrd.equals("ENG")) out.print("selected");%> >영문상품</option>
					</select>
				</div>
				
				<div class="form-group">
					<input type="text" class="form-control" placeholder="검색어를 입력하세요" name="keyword" maxlength="20" id="keyword" value="<%if(keyword!=null&& !keyword.equals("")) out.print(keyword);%>">
				</div>
				<div class="form-group">
					<button  class="btn btn-primary">검색</button>
					<button type="button" class="btn btn-primary" onclick="searchReset()">검색 초기화</button>
				</div>
				
			   <div class="text-right totalCount">
			   		<%=nf.format(totalCount)%> 건				
				</div>
			</form>

			<table class="table table-hover table-responsive" id="products_11_st">
				<thead class="text-center">
					<tr>
						<th class="text-center">상품</th>
						<th class="text-center" width="10%">가격</th>
					</tr>
				</thead>

				<tbody>
					<%
						if (productList != null && productList.size() > 0) {
									for (ProductSearch11stVO product : productList) {
					%>
					<tr class="text-center">
						
						<td class="text-left">

							<div class="row">
								<div class="col-12 col-sm-3">
									<a href="<%=product.getDetailPageUrl()%>" target="_blank">
										<img src="<%=product.getProductImage170()%>">
									</a>
								</div>

								<div class="col-12 col-sm-9">
									<div class="row">
										<div class="c_prd_name col-sm-12">
											<a href="<%=product.getDetailPageUrl()%>" target="_blank"><strong><%=product.getProductName()%></strong></a>
										</div>


										<div class="col-sm-12 c_prd_meta">

										<div class="wrap-star">										   
										    <div class='star-rating'>
										        <span style ="width:<%=product.getRating()%>%"></span>		
										    </div>
										    	<%
										    		if(product.getReviewCount()!=null && !product.getReviewCount().equals("") ){										    			
										    			if(Integer.parseInt(product.getReviewCount()) >0){
										    	%>
										    	<a href="#" class="c_review" onclick="return false">
													<span class="title">리뷰</span>
													<em><%=product.getReviewCount()%></em><span class="unit">건</span>
											    </a>										    	
										    	<%			
										    			}
										    		}
										    	%>										    
										</div> 							        
												
										</div>


										<div class="col-sm-12">
											<div class="text-delivery">
											<%
											
												if(product.getDelivery()!=null & !product.getDelivery().equals("")){													
													if(product.getDelivery().equals("무료")){
														out.print(product.getDelivery());
													}else{
														out.print("배송비 2,500원");
													}
												}
											%>
											</div>
										</div>
										
										<div class="col-sm-12">
											<div class="c_prd_sellerNick">										
											<span class="name"><%=product.getSellerNick()%></span>
											</div>
										</div>
									</div>

								</div>
							</div>



						</td>
						<td><strong class="price_seller"><%=nf.format(Integer.parseInt(product.getSalePrice()))%></strong>
							<span class="text-unit">원</span>
						</td>
					</tr>
					<%
						}
					} else {
					%>
					<tr class="text-center">
						<td colspan="3" class="text-center"><h3>검색결과가 없습니다.</h3></td>
					</tr>
					<%
						}
					%>
				</tbody>
				<tfoot>
					<tr>
					<td colspan="3" class="text-center">
						<%  if(paging!=null)out.print(paging);%>
					</td>
					</tr>
				</tfoot>
			</table>



		</div>
	</div>






	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	
<script type="text/javascript">
function searchReset(){
	location.href="<%=currentURL.toString()+"?&keyword="%>";
}

</script>	
</body>
</html>