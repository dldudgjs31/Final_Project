package com.sp.app.daily;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;
@Service("daily.dailyService")
public class DailyServiceImpl implements DailyService{
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertDaily(Daily dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("daily.seq");			
			
			dto.setDailyNum(seq);
			dao.insertData("daily.insertDaily",dto);
			
			// 파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String imageFilename=fileManager.doFileUpload(mf, pathname);
					if(imageFilename==null) continue;	
					dto.setImageFilename(imageFilename);
					int image_seq = dao.selectOne("daily.image_seq");
					dto.setDaily_imageFilenum(image_seq);		
					insertFile(dto);
				}
						}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0 ;
		
		try {
			result = dao.selectOne("daily.dailyCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Daily> listDaily(Map<String, Object> map) {
		List<Daily> list = null;
		try {
			list = dao.selectList("daily.listDaily",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Daily> listDailyTop() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Daily readDaily(int dailyNum) throws Exception {
		Daily dto = null;
		try {
			dto = dao.selectOne("daily.readDaily",dailyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateDaily(Daily dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDaily(int dailyNum, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertFile(Daily dto) throws Exception {
		try {
			dao.insertData("daily.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Daily> listFile(int dailyNum) {
		List<Daily> listFile = null;
		try {
			listFile = dao.selectList("daily.listFile",dailyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Daily readFile(int fileNum) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("daily.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}
