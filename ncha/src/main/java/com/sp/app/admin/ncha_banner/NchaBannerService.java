package com.sp.app.admin.ncha_banner;

import java.util.List;

public interface NchaBannerService {
	public void insertImage(NchaBanner dto, String pathname)throws Exception;
	public List<NchaBanner> listFile();
	public void updateImage(NchaBanner dto, String pathname) throws Exception;
	public void deleteImage(int fileNum) throws Exception;
	public void deleteAll() throws Exception;
}
