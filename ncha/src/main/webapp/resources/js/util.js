// 내용의 값의 빈공백을 trim(앞/뒤)
if(typeof String.prototype.trim !== 'function') {
    String.prototype.trim = function() {
        var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
        return this.replace(TRIM_PATTERN, "");
    };
}

// 이미지 파일인지 검사
function isImageFile(filename){
    var format = /(\.gif|\.jpg|\.jpeg|\.png)$/i;
    return format.test(filename);
}

// 이메일 형식 검사
function isValidEmail(data){
    var format = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
    return format.test(data); // true : 올바른 포맷 형식
}

// SQL 문 존재 여부 검사
function isValidSQL(data){
    var format=/(SELECT|INSERT|UPDATE|DELETE|CREATE|ALTER|DROP|EXEC|UNION|FETCH|DECLARE|TRUNCATE)/gi;
    return format.test(data);
}

// class 속성 값중 특정값을 가진 태그 찾기
function getElementsByClass(searchClass,node,tag) {
    var classElements = [];
    if ( node === null )
        node = document;
    if ( tag === null )
        tag = '*';
    var els = node.getElementsByTagName(tag);
    var elsLen = els.length;
    var pattern = new RegExp('(^|\\s)'+searchClass+'(\\s|$)');
    for (i = 0, j = 0; i < elsLen; i++) {
        if ( pattern.test(els[i].className) ) {
            classElements[j] = els[i];
            j++;
        }
    }
    return classElements;
}

// 모든 태그에서 해당 속성과 속성의 값을 검색하여 해당 태그를 배열로 반환
function getElementsByAttr(attrName, attrValue) {
	var elements = document.getElementsByTagName("*");
	var foundElements=[];
	
	for(var i=0; i<elements.length; i++) {
		if(elements[i].hasAttribute(attrName) && 
				elements[i].getAttribute(attrName).toLowerCase()==attrValue.toLowerCase()) {
			foundElements.push(elements[i]);
		}
	}
	
	return foundElements;	
}

// 숫자와 영문자만 입력 허용
function onlyAlpNum() {
     if((event.keyCode < 48) || 
         ((event.keyCode > 57) && (event.keyCode < 65)) || 
         ((event.keyCode > 90) && (event.keyCode < 97)) || 
         (event.keyCode > 122)) {
          try {
              event.preventDefault(); //이벤트 취소
          } catch (e) {
              event.returnValue=false; //IE 8 이하
          }
     }
}

// -------------------------------------------------
// 이벤트 등록
/* 
    // 사용 예
    var func= function() { alert('예제'); }
    addEvent(window, load, func);
*/
function addEvent(elm, evType, fn) {
    if (elm.addEventListener) {
        elm.addEventListener(evType, fn, false);
        return true;
    } else if (elm.attachEvent) {
        var r = elm.attachEvent('on' + evType, fn);
        return r;
    } else {
        elm['on' + evType] = fn;
    }
}

// -------------------------------------------------
// 팝업 윈도우즈
function winOpen(url, windowName, windowFeatures) {
	if(! theURL) return;
	if(! windowName) windowName="";
	
	var flag = windowFeatures;
    if(flag == undefined) {
		flag = "left=10, ";
		flag += "top=10, ";
		flag += "width=372, ";
		flag += "height=466, ";
		flag += "toolbar=no, ";
		flag += "menubar=no, ";
		flag += "status=no, ";
		flag += "scrollbars=no, ";
		flag += "resizable=no";
		// flag = "scrollbars=no,resizable=no,width=220,height=230";
	}
	
    window.open(url, windowName, flag);
}

// -------------------------------------------------
// 기타 형식 검사
// 영문, 숫자 인지 확인
 function isValidEngNum(str) {
    for(var i=0;i<str.length;i++) {
        achar = str.charCodeAt(i);                 
        if( achar > 255 )
            return false;
    }
    return true; 
}

// 전화번호 형식(숫자-숫자-숫자)인지 체크
function isValidPhone(data) {
    // var format = /^(\d+)-(\d+)-(\d+)$/;
    var format=/^(01[016789])-[0-9]{3,4}-[0-9]{4}$/g;
    return format.test(data);
}

// 문자열에 특수문자(",  ',  <,  > ) 검사
function isValidSpecialChar(str) {
    if(str.value.search(/[\",\',<,>]/g) >= 0)
        return true; // 존재 하면
    return false;
}
