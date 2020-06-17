package store;

import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.CharacterData;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;


//상품검색 - 기본정보조회

public class Api11stProductSearchParsing {

    private static Api11stProductSearchParsing instance = null;
    
    private final static String KEY ="키값";
    
    private final static String API_CODE="ProductSearch";
    
    private final static String URL_11ST="http://openapi.11st.co.kr/openapi/OpenApiService.tmall?key="+KEY+"&apiCode="+API_CODE;
        
    private Api11stProductSearchParsing(){ 
    	
    }
        
    public static Api11stProductSearchParsing getInstance() {
        if(instance == null) {
            instance = new Api11stProductSearchParsing();             
        }
        return instance;
    }
  
    private String getCharacterDataFromElement(Element e) {
        try {
            Node child = e.getFirstChild();
            if(child instanceof CharacterData) {
                CharacterData cd = (CharacterData) child;
                return cd.getData();
            }
        }catch(Exception ex) {
           ex.printStackTrace();
        }
        return "";          
    } 

    private String getElementValue(Element parent,String label) {
        return getCharacterDataFromElement((Element)parent.getElementsByTagName(label).item(0));  
    }

    
	/**
	key	String	O	OpenAPI 가입 시 발급받는 32자리 문자 Key
	 apiCode	String	O	OpenAPI 서비스 코드 → 상품검색 : ProductSearch
	 Keyword	String	O	검색 요청 값
	 pageNum	String	O	페이지 넘버(Default 1)
	pageSize	String	X	한페이지에 출력되는 상품 수(Default 50, 최대 200)
	sortCd	String	X	정렬순서
	    	→ CP : 인기도순
	    	→ A : 누적판매순
	    	→ G : 평가높은순
	    	→ I : 후기/리뷰많은순
	    	→ L : 낮은가격순
	    	→ H : 높은가격순
	    	→ N : 최근등록순
	option	String	X	Default로 제공되는 상품리스트 이외의 부가정보 요청 파라메터 입니다.
	 Categories : 카테고리 검색 결과 요청
	targetSearchPrd	String	X	상품 검색 대상(Default KOR) → ENG : 영문상품 → KOR : 국문상품
	*/ 
    //url 파라미터 셋팅
    protected static String urlParameterSetting(String keyword,String pageNum,String pageSize,String sortCd, String option, String categories, 
    		String targetSearchPrd, String categoryCode,boolean parameterValue) {
    	
    	String url=URL_11ST; 
    	String parameter="";
    		
		if(keyword!=null && !keyword.equals("")) {
    		try {				
    			parameter=parameter+"&keyword="+URLEncoder.encode(keyword , "UTF-8");
			} catch (UnsupportedEncodingException e) {				
				e.printStackTrace();
			}    		
    	}else{
    		parameter=parameter+"&keyword=";
    	}    	
    	
     	if(pageNum!=null && !pageNum.equals("")) parameter=parameter+"&pageNum="+pageNum;
    	
    	if(pageSize!=null && !pageSize.equals("")) parameter=parameter+"&pageSize="+pageSize;
    		
    	if(sortCd!=null && !sortCd.equals("")) parameter=parameter+"&sortCd="+sortCd;
    	
    	if(option!=null && !option.equals("")) parameter=parameter+"&option="+option;
    	
    	if(categories!=null && !categories.equals("")) parameter=parameter+"&Categories="+categories;
    	
    	if(targetSearchPrd!=null && !targetSearchPrd.equals("")) parameter=parameter+"&targetSearchPrd="+targetSearchPrd;
    	
    	if(categoryCode!=null && !categoryCode.equals("")) parameter=parameter+"&option=Categories&dispCtgrNo="+categoryCode;
    	
    	
    	
    	if(parameterValue){ //파라미터값 만 반환 할 경우 true 값
        	return parameter;
    	}
 
    	System.out.println("url+parameter : " +url+parameter);
    	return url+parameter;	
    }  
    
    
    
     
    public List<ProductSearch11stVO> xmlParsingProductList(String Keyword,String pageNum,String pageSize,String sortCd, String option, String Categories, String targetSearchPrd, String categoryCode) {
    	List<ProductSearch11stVO> productSearchList=null;
        try {
        	String url=urlParameterSetting(Keyword,pageNum,pageSize,sortCd,option,Categories,targetSearchPrd,categoryCode,false);

            DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
            URL u = new URL(url);          
            Document doc = builder.parse(u.openStream());
          
            //전체 갯수
            NodeList nodesProductsRoot = doc.getElementsByTagName("Products");    
            Element rootElement = (Element)nodesProductsRoot.item(0);
            String totalCount=getElementValue(rootElement,"TotalCount");
            
            
            NodeList nodesProducts = doc.getElementsByTagName("Product");         
            productSearchList=new ArrayList<ProductSearch11stVO>();
            
            
            for(int i=0;i<nodesProducts.getLength();i++) {
              
                Element element = (Element)nodesProducts.item(i);
                ProductSearch11stVO productSearch =new ProductSearch11stVO();
                
                productSearch.setTotalCount(totalCount);                
                productSearch.setProductCode(getElementValue(element,"ProductCode"));			
                productSearch.setProductName(getElementValue(element,"ProductName"));			
                productSearch.setProductPrice(getElementValue(element,"ProductPrice"));  		
                productSearch.setProductImage(getElementValue(element,"ProductImage"));  		
                productSearch.setProductImage100(getElementValue(element,"ProductImage100"));
                productSearch.setProductImage110(getElementValue(element,"ProductImage110"));
                productSearch.setProductImage120(getElementValue(element,"ProductImage120"));
                productSearch.setProductImage130(getElementValue(element,"ProductImage130"));
                productSearch.setProductImage140(getElementValue(element,"ProductImage140"));
                productSearch.setProductImage150(getElementValue(element,"ProductImage150"));
                productSearch.setProductImage170(getElementValue(element,"ProductImage170"));
                productSearch.setProductImage200(getElementValue(element,"ProductImage200"));
                productSearch.setProductImage250(getElementValue(element,"ProductImage250"));
                productSearch.setProductImage270(getElementValue(element,"ProductImage270"));
                productSearch.setProductImage300(getElementValue(element,"ProductImage300"));
                productSearch.setText1(getElementValue(element,"Text1"));
                productSearch.setText2(getElementValue(element,"Text2"));
                productSearch.setSellerNick(getElementValue(element,"SellerNick")); 			 
                productSearch.setSeller(getElementValue(element,"Seller")); 				
                productSearch.setSellerGrd(getElementValue(element,"SellerGrd"));  			 
                productSearch.setRating(getElementValue(element,"Rating"));  			
                productSearch.setDetailPageUrl(getElementValue(element,"DetailPageUrl")); 		
                productSearch.setSalePrice(getElementValue(element,"SalePrice"));   		
                productSearch.setDelivery(getElementValue(element,"Delivery")); 			
                productSearch.setReviewCount(getElementValue(element,"ReviewCount")); 		
                productSearch.setBuySatisfy(getElementValue(element,"BuySatisfy")); 		
                productSearch.setMinorYn(getElementValue(element,"MinorYn")); 
                // Benefit 태그           
                NodeList benefit = element.getElementsByTagName("Benefit");
				for(int a = 0; a < benefit.getLength(); a++){
					Node nodeBenefit = benefit.item(a);
					if(nodeBenefit.getNodeType() == Node.ELEMENT_NODE){
						Element eleBenefit = (Element)nodeBenefit;
						productSearch.setDiscount(getElementValue(eleBenefit,"Discount")); 		
	                    productSearch.setMileage(getElementValue(eleBenefit,"Mileage"));
					}
				}

				productSearchList.add(productSearch);                
            }   
                        
        }catch(Exception ex) {
        	productSearchList=null;
            ex.printStackTrace();  
        }
      
        return productSearchList;
    }
    
    
   public List<Categories11stVO> xmlParsingCategories11st() {
    	List<Categories11stVO> categories11st=null;
       try {

          String url=URL_11ST; 
      	  String parameter="&keyword=&option=Categories";
      	  url=url+parameter;
      	  
           DocumentBuilder builder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
           URL u = new URL(url);          
           Document doc = builder.parse(u.openStream());

           
           NodeList nodesCategorys = doc.getElementsByTagName("Category");         
           categories11st=new ArrayList<Categories11stVO>();
           
           
           for(int i=0;i<nodesCategorys.getLength();i++) {
             
               Element element = (Element)nodesCategorys.item(i);
               Categories11stVO categories11stVO =new Categories11stVO();

               categories11stVO.setCategoryPrdCnt(getElementValue(element,"CategoryPrdCnt")); 		
               categories11stVO.setCategoryName(getElementValue(element,"CategoryName"));
               categories11stVO.setCategoryUrl(getElementValue(element,"CategoryUrl"));
			   categories11st.add(categories11stVO);                
           }   
                       
       }catch(Exception ex) {
    	   categories11st=null;
           ex.printStackTrace();  
       }     
       return categories11st;
   }
    
    
    
    

}
