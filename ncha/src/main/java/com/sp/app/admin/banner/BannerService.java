package com.sp.app.admin.banner;

import java.util.List;

public interface BannerService {
	public void insertImage(Banner dto, String pathname)throws Exception;
	public List<Banner> listFile() throws Exception;
	public void updateImage(Banner dto, String pathname) throws Exception;
	public void deleteImage(int fileNum) throws Exception;
	public void deleteAll() throws Exception;
}
