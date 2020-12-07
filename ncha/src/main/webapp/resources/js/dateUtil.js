// 날짜 형식 검사 정규표현식
function isValidDateFormat(data){
    var regexp = /^[12][0-9]{3}[\.|\-|\/]?[0-9]{2}[\.|\-|\/]?[0-9]{2}$/;
    if(! regexp.test(data))
        return false;

    regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
	var y=parseInt(data.substr(0, 4));
    var m=parseInt(data.substr(4, 2));
    if(m<1||m>12) 
    	return false;
    var d=parseInt(data.substr(6));
    var lastDay = (new Date(y, m, 0)).getDate();
    if(d<1||d>lastDay)
    	return false;
		
	return true;
}

// 날짜가 정확한지 검사
function isValidDate(year, month, day){
    var y, m, d;
	
    y = String(year);  // 숫자인 경우 문자로 변환
    m = String(month);
    d = String(day);
    
    y = y.trim();
    m = m.trim();
    d = d.trim();
    if(! /^\d{4}$/.test(y) || ! /^\d{2}$/.test(m) || ! /^\d{2}$/.test(d)) {
        return false;
    }

    y = parseInt(year);
    m = parseInt(month);
    d = parseInt(day);

    // 날짜 검사
	var date=new Date(y, m-1, d); 
	if(y != date.getFullYear() || m != date.getMonth()+1 || d != date.getDate()) {
		return false;
	}

    return true;
}

// 월의 마지막 날짜 반환
function lastDayOfMonth(y, m) {
	// var date = new Date(y, m, 1-1);
	var date = new Date(y, m, 0);
	return date.getDate();
}

// 날짜를 문자열로
function dateToString(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    if(m < 10) m='0'+m;
    var d = date.getDate();
    if(d < 10) d='0'+d;
    
    return y + '-' + m + '-' + d;
}

// 문자열을 날짜로
function stringToDate(value) {
    if(! isValidDateFormat(value)) {
    	throw "날짜 형식이 올바르지 않습니다.";
    }
		
    var format=/(\.)|(\-)|(\/)/g;
    value=value.replace(format, "");
    
    var y = parseInt(value.substr(0, 4));
    var m = parseInt(value.substr(4, 2));
    var d = parseInt(value.substr(6, 2));
    
    return new Date(y, m-1, d);
}

// 기준일부터 몇일후(기준일 포함)
function daysLater(sDate, days) {
    if(! isValidDateFormat(sDate)) {
    	throw "날짜 형식이 올바르지 않습니다.";
    }
	
    var y, m, d, s;
    var date=new Date();
    var regexp=/(\.)|(\-)|(\/)/g;
    sDate=sDate.replace(regexp, "");
    
    y = parseInt(sDate.substr(0, 4));
    m = parseInt(sDate.substr(4, 2));
    // d = parseInt(sDate.substr(6, 2))+parseInt(days);
    d = parseInt(sDate.substr(6, 2))+parseInt(days)-1;

    date.setFullYear(y, m-1, d);

    y=date.getFullYear();
    m=date.getMonth()+1;
    if(m<10) m="0"+m;
    d=date.getDate();
    if(d<10) d='0'+d;
    
    s=y+"-"+m+"-"+d;

    return s;
}

// 두 날짜간의 간격 계산
function diffDays(sDate, eDate) {
	if(! isValidDateFormat(sDate) || ! isValidDateFormat(eDate)) {
		throw "날짜 형식이 올바르지 않습니다.";
	}
	
    var regexp=/(\.)|(\-)|(\/)/g;
    sDate=sDate.replace(regexp, "");
    eDate=eDate.replace(regexp, "");
    
    var sy = parseInt(sDate.substr(0, 4));
    var sm = parseInt(sDate.substr(4, 2));
    var sd = parseInt(sDate.substr(6, 2));
    
    var ey = parseInt(eDate.substr(0, 4));
    var em = parseInt(eDate.substr(4, 2));
    var ed = parseInt(eDate.substr(6, 2));

    var date1=new Date(sy, sm-1, sd);
    var date2=new Date(ey, em-1, ed);
    
    var sn=date1.getTime();
    var en=date2.getTime();
    var count=en-sn;
    var day=Math.floor(count/(24*3600*1000));
    
    // return day;
    return day+1;
}

// 나이 계산
function toAge(data) {
	if(! isValidDateFormat(data)) {
		throw "날짜 형식이 올바르지 않습니다.";
	}
	
    var regexp=/(\.)|(\-)|(\/)/g;
    data=data.replace(regexp, "");
    
    var by = parseInt(data.substr(0, 4));
    var bm = parseInt(data.substr(4, 2));
    var bd = parseInt(data.substr(6, 2));
    var bdate=new Date(by, bm-1, bd);
    var now = new Date();
    
    var age=now.getFullYear() - bdate.getFullYear();
    if((bdate.getMonth() > now.getMonth()) ||
            ((bdate.getMonth() == now.getMonth()) && 
                    bdate.getDate() > now.getDate())) {
        age--;
    }
    
    return age;
}
