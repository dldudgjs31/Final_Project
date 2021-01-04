package com.sp.app.store;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;
import com.sp.app.customer.Customer;
import com.sp.app.store_profile.Option;

@Service("store.storeService")
public class StoreServiceImpl implements StoreService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	// 상품 DB 등록
	@Override
	public void insertProduct(Store dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("store.seq");
			dto.setProductNum(seq);
			dao.insertData("store.insertProduct", dto);

			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String imageFilename=fileManager.doFileUpload(mf, pathname);
					if(imageFilename==null) continue;
					dto.setImageFilename(imageFilename);
					int image_seq = dao.selectOne("store.image_seq");
					dto.setMain_imageFileNum(image_seq);
					insertFile(dto);
				}
			}
			
	
		} catch (Exception e) {
			e.printStackTrace();
			throw e;			
		}
		
	}
	
	// 상품 옵션 등록
	@Override
	public void insertOption(Store dto) throws Exception {
		try {
				Map<String, Object> map = new HashMap<>();
				map.put("productNum",dto.getProductNum());
				for(int i =0; i < dto.getOption_stock().size();i++) {
					map.put("optionDetail", dto.getOptionDetail().get(i));
					map.put("option_stock", dto.getOption_stock().get(i));
					dao.insertData("store.insertOption", map);
				}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	
	@Override
	public List<Store> listProduct(Map<String, Object> map) {
		List<Store> list = null;
		
		try {
			list=dao.selectList("store.listProduct",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		
		try {
			result=dao.selectOne("store.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Store readProduct(int num) {
		Store dto =null;
		try {
			dto = dao.selectOne("store.readProduct",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("store.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Store preReadProduct(Map<String, Object> map) {
		Store dto =null;
		try {
			dto=dao.selectOne("store.preReadProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public Store nextReadProduct(Map<String, Object> map) {
		Store dto =null;
		try {
			dto=dao.selectOne("store.nextReadProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateProduct(Store dto) throws Exception {
		try {
			dao.updateData("store.updateProduct", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void delete(int num, String sellerId) throws Exception {
		Store dto = null;
		try {
			dto = readProduct(num);
			if( dto==null || ( !sellerId.equals("admin") && ! dto.getSellerId().equals(sellerId) )) {
				return;
			}
			dao.deleteData("store.deleteProduct", num);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertFile(Store dto) throws Exception {
		try {
			dao.insertData("store.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Store> readProductFile(int productNum) throws Exception {
		List<Store> list1 = null;
		try {
			list1 = dao.selectList("store.listArticleFile", productNum);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list1;
	}

	@Override
	public List<Store> listFile(int productNum) throws Exception {
		List<Store> listFile = null;
		try {
			listFile = dao.selectList("store.listFile", productNum);
		} catch (Exception e) {
		}
		return listFile;
	}

	@Override
	public List<Store> readOption(int productNum) throws Exception {
		List<Store> optionList = null;
		try {
			optionList = dao.selectList("store.listOption",productNum);
		} catch (Exception e) {
		}
		return optionList;
	}

	@Override
	public void deleteImage(int main_imageFileNum) throws Exception {
		try {
			dao.deleteData("store.deleteImage", main_imageFileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteOption(int optionNum) throws Exception {
		try {
			dao.deleteData("store.deleteOption", optionNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteAllOption(int productNum) throws Exception {
		try {
			dao.deleteData("store.deleteAllOption", productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteAllImage(int productNum) throws Exception {
		try {
			dao.deleteData("store.deleteAllImage", productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public String readCategoryName(String categoryNum) throws Exception {
		String categoryName="";
		try {
			categoryName =dao.selectOne("store.readCategoryName", Integer.parseInt(categoryNum));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return categoryName;
	}

	@Override
	public Store readProduct() {
		Store dto =null;
		try {
			dto = dao.selectOne("store.readProductMain");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<Store> listMyProduct(Map<String, Object> map) throws Exception {
		List<Store> list = null;
		try {
			list = dao.selectList("store.listMyProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCountMyproduct(Map<String, Object> map) throws Exception {
		int dataCount =0;
		try {
			dataCount=dao.selectOne("store.dataCountMyproduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}

	@Override
	public void updateMyStock(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("store.updateMyStock", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public void insertMyOption(Option dto) throws Exception {
		try {
			dao.insertData("store.insertMyOption", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int dataMySoldCount(Map<String, Object> map) throws Exception {
		int dataCount =0;
		try {
			dataCount=dao.selectOne("store.dataMySoldCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}

	@Override
	public int dataMyProductCount(Map<String, Object> map) throws Exception {
		int dataCount =0;
		try {
			dataCount=dao.selectOne("store.dataMyProductCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}

	@Override
	public int readBestReviewProduct(Map<String, Object> map) throws Exception {
		int productNum =0;
		try {
			productNum=dao.selectOne("store.readBestReviewProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return productNum;
	}

	@Override
	public int readWorstReviewProduct(Map<String, Object> map) throws Exception {
		int productNum =0;
		try {
			productNum=dao.selectOne("store.readWorstReviewProduct", map);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
		return productNum;
	}

	@Override
	public List<Customer> listRecentSoldProduct(Map<String, Object> map) throws Exception {
		List<Customer> list = null;
		try {
			list = dao.selectList("store.listRecentSoldProduct", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("store.insertLike", map);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public int checkLike(Map<String, Object> map) throws Exception {
		int check =0;
		try {
			check= dao.selectOne("store.checkLike", map);
		} catch (Exception e) {
			throw e;
		}
		return check;
	}

	@Override
	public void deleteLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("store.deleteLike", map);
		} catch (Exception e) {
			throw e;
		}
		
	}

	@Override
	public int dataLikeCount(Map<String, Object> map) throws Exception {
		int dataCount =0;
		try {
			dataCount=dao.selectOne("store.dataLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}

	@Override
	public int dataProductLikeCount(int productNum) throws Exception {
		int dataCount =0;
		try {
			dataCount=dao.selectOne("store.dataProductLikeCount", productNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	}

	@Override
	public int dataStoreLikeCount(Map<String, Object> map) throws Exception {
		int dataCount =0;
		try {
			dataCount=dao.selectOne("store.dataStoreLikeCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCount;
	} 



}
