package com.sp.app.store;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("store.storeService")
public class StoreServiceImpl implements StoreService {
	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
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
			// TODO: handle exception
		}
		return listFile;
	}

}
