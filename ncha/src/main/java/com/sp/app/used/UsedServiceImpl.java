package com.sp.app.used;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("used.usedService")
public class UsedServiceImpl implements UsedService {
	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager fileManager;

	@Override
	public void insertUsed(Used dto, String pathname) throws Exception {
		try {

			int seq = dao.selectOne("used.used_seq");// 중고글 시퀀스
			dto.setUsedNum(seq);

			dao.insertData("used.insertUsed", dto);

			if (!dto.getUpload().isEmpty()) {

				for (MultipartFile mf : dto.getUpload()) {

					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if (saveFilename == null)
						continue;

					dto.setImageFilename(saveFilename);
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("used.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Used> listUsed(Map<String, Object> map) {
		List<Used> list = null;
		try {
			list = dao.selectList("used.listUsed", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("used.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Used readUsed(int num) {
		Used dto = null;
		try {
			dto = dao.selectOne("used.readUsed", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Used preReadDto(Map<String, Object> map) {
		Used dto = null;

		try {
			dto = dao.selectOne("used.preReadDto", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public Used nextReadDto(Map<String, Object> map) {
		Used dto = null;

		try {
			dto = dao.selectOne("used.nextReadDto", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return dto;
	}

	@Override
	public void updateUsed(Used dto, String pathname) throws Exception {
		try {
			dao.updateData("used.updateUsed", dto);
			//deleteImage(dto.getUsed_imageFileNum());
			
			if (!dto.getUpload().isEmpty()) {
				for (MultipartFile mf : dto.getUpload()) {
					String saveFilename = fileManager.doFileUpload(mf, pathname);
					if (saveFilename == null)
						continue;
					dto.setImageFilename(saveFilename);

					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteUsed(int usedNum, String pathname) throws Exception {
		try {
			//서버에 파일 지우기
			List<Used> listFile = listFile(usedNum);
			if(listFile != null) {
				for(Used dto:listFile) {
					fileManager.doFileDelete(dto.getImageFilename(),pathname);
				}
			}
			
			//테이블내용 지우기
			Map<String, Object> map = new HashMap<>();
			map.put("field","usedNum");
			map.put("usedNum",usedNum);
			deleteAllImage(map);
			
			dao.deleteData("used.deleteUsed",usedNum);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	//파일
	@Override
	public void insertFile(Used dto) throws Exception {
		try {
			dao.insertData("used.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Used> listFile(int num) {
		List<Used> listFile = null;

		try {
			listFile = dao.selectList("used.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public Used readFile(int fileNum) {
		Used dto = null;
		try {
			dto = dao.selectOne("used.readImage",fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	
	@Override
	public void deleteAllImage(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("used.deleteAllImage",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Used> readUsedFile(int usedNum) throws Exception {
		List<Used> images = null;
		try {
			images = dao.selectList("used.readimagelist");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return images;
	}

	@Override
	public void deleteImage(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("used.deleteimage",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
