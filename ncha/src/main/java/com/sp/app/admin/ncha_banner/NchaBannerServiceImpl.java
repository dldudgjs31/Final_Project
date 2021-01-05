package com.sp.app.admin.ncha_banner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("admin.ncha_banner.nchaBannerService")
public class NchaBannerServiceImpl implements NchaBannerService{

	@Autowired
	private CommonDAO dao;
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertImage(NchaBanner dto, String pathname) throws Exception {
		
		try {
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf : dto.getUpload()) {
					int num =  dao.selectOne("nchabanner.nchabanner_seq");
					dto.setFileNum(num);
					
					String imageFilename = fileManager.doFileUpload(mf, pathname);
					if(imageFilename==null) continue;
					
					dto.setServerFilename(imageFilename);
					dao.insertData("nchabanner.insertBanner",dto);
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<NchaBanner> listFile() {
		List<NchaBanner>list = null;
		
		try {
			list = dao.selectList("nchabanner.imageList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void deleteImage(int fileNum) throws Exception {
		try {
			dao.deleteData("nchabanner.deleteImage",fileNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateImage(NchaBanner dto, String pathname) throws Exception {
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
			dao.deleteData("nchabanner.deleteAll");
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
}
