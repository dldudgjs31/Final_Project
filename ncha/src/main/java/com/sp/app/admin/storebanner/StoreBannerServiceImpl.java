package com.sp.app.admin.storebanner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("admin.storebanner.StorebannerService")
public class StoreBannerServiceImpl implements StoreBannerService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertImage(StoreBanner dto, String pathname) throws Exception {
		
		try {
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					int num =  dao.selectOne("storebanner.storebanner_seq");
					dto.setFileNum(num);
					
					String imageFilename = fileManager.doFileUpload(mf, pathname);
					if(imageFilename==null) continue;
					
					dto.setServerFilename(imageFilename);
					dao.insertData("storebanner.insertBanner",dto);
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<StoreBanner> listFile() {
		List<StoreBanner>list = null;
		
		try {
			list = dao.selectList("storebanner.imageList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteImage(int fileNum) throws Exception {
		try {
			dao.deleteData("storebanner.deleteImage",fileNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateImage(StoreBanner dto, String pathname) throws Exception {
		try {
			if(!dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					String imageFilename = fileManager.doFileUpload(mf, pathname);
					if(imageFilename == null)continue;
					
					dto.setServerFilename(imageFilename);
					insertImage(dto, pathname);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteAll() throws Exception {
		try {
			dao.deleteData("storebanner.deleteAll");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}
