package store;

public class Categories11stVO {

	private String categoryPrdCnt;
	private String categoryName;
	private String categoryUrl;
	
	
	public String getCategoryPrdCnt() {
		return categoryPrdCnt;
	}
	public void setCategoryPrdCnt(String categoryPrdCnt) {
		this.categoryPrdCnt = categoryPrdCnt;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public String getCategoryUrl() {
		return categoryUrl;
	}
	public void setCategoryUrl(String categoryUrl) {
		this.categoryUrl = categoryUrl;
	}
	
	@Override
	public String toString() {
		return "Categories11st [categoryPrdCnt=" + categoryPrdCnt + ", categoryName=" + categoryName + ", categoryUrl="
				+ categoryUrl + "]";
	}
	
	
	
}

