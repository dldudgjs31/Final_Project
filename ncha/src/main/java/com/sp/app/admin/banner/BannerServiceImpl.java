package com.sp.app.admin.banner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("admin.banner.bannerService")
public class BannerServiceImpl implements BannerService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertImage(Banner dto, String pathname) throws Exception {
		
		try {
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					int num =  dao.selectOne("adminbanner.storebanner_seq");
					dto.setFileNum(num);
					
					String imageFilename = fileManager.doFileUpload(mf, pathname);
					if(imageFilename==null) continue;
					
					dto.setServerFilename(imageFilename);
					dao.insertData("adminbanner.insertBanner",dto);
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Banner> listFile() throws Exception {
		List<Banner>list = null;
		
		try {
			list = dao.selectList("adminbanner.imageList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteImage(int fileNum) throws Exception {
		try {
			dao.deleteData("adminbanner.deleteImage",fileNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateImage(Banner dto, String pathname) throws Exception {
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
			dao.deleteData("adminbanner.deleteAll");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}
