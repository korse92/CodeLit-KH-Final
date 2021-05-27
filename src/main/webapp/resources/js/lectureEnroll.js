$((e) => {
	$(thumbImage).click(e => {
		$(lectureThumbnail).trigger('click');
	});

	$(lectureThumbnail).change(e => {
		const target = e.target;
		const files = target.files;

		// FileReader support
		if (FileReader && files && files.length) {
			var fr = new FileReader();
			fr.onload = function () {
					document.getElementById("thumbImage").src = fr.result;
			}
			fr.readAsDataURL(files[0]);
		}
		// Not supported
		else {
			// fallback -- perhaps submit the input to an iframe and temporarily store
			// them on the server until the user's session ends.
			document.getElementById("thumbImage").src = "https://via.placeholder.com/450x300.png?text=Thumbnail+Image";
		}
	});

	$("[name=lectureEnrollFrm").on('reset', e => {
		document.getElementById("thumbImage").src = "https://via.placeholder.com/450x300.png?text=Thumbnail+Image";
	});

	//ckeditor 생성
	CKEDITOR.replace('lectureIntro', {
		height: 500
	});

	$("[name=lectureEnrollFrm]").submit(e => {
		var $lectureGuideline = $(lectureGuideline)
		if(!$lectureGuideline.val()){
			$lectureGuideline.val(1);
		}

		var $lecturePrice = $(lecturePrice)
		if(!$lecturePrice.val()){
			$lecturePrice.val(0);
		}

		$("[name=curriculum]").val(createCurriculum());

		//e.preventDefault();//테스트용
	});

	$(curtest).click(e => {
		createCurriculum();
	});

	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl)
	});

	$(".partAddBtn").click(e => {
		//최상위 div
		let $partGroup = $("<div></div>",{
			"class" : "part-group w-100"
		});

		//파트 .input-group div
		let $inputGroup = $("<div></div>", {
			"class" : "input-group"
		});

		let $partDelBtn = $("<button></button>", {
			"type" : "button",
			"class" : "btn p-0 me-2 partDelBtn",
			"data-bs-toggle" : "tooltip",
			"data-bs-placement" : "left",
			"title" : "파트 삭제"
		});
		$partDelBtn.append("<i class='fas fa-minus-square text-warning fs-3'></i>");
		$partDelBtn.click(partDelBtnClickListener);

		let $partInput= $("<input>", {
			"type" : "text",
			"class" : "partInput form-control my-1",
			"placeholder" : "파트 제목 입력"
		});

		$inputGroup.append($partDelBtn, $partInput);

		//챕터 추가 버튼
		let $chapAddBtn = $("<button></button>", {
			"type" : "button",
			"class" : "btn chapAddBtn ms-5 mt-1 p-0",
			"data-bs-toggle" : "tooltip",
			"data-bs-placement" : "left",
			"title" : "챕터 추가"
		});

		$chapAddBtn.append("<i class='fas fa-plus-square text-primary fs-3'></i>");
		$chapAddBtn.click(chapAddBtnClickListener);

		//div.input-group, button.chapAddBtn 추가
		$partGroup.append($inputGroup, $chapAddBtn);

		//console.log($partDiv);
		//console.log($(e.target).parent());

		//파트 추가 버튼 이전의 형제요소로 추가
		const $partAddBtn = $("#inputCurriculum > .partAddBtn");
		$partAddBtn.before($partGroup);
		tooltipInit($partAddBtn.prev());
	});

	$(".chapAddBtn").click(chapAddBtnClickListener);
	$(".partDelBtn").click(partDelBtnClickListener);
	$(".chapDelBtn").click(chapDelBtnClickListener);
});

function chapAddBtnClickListener(e) {
	//최상위 .chapter-group div
	let $chapterGroup = $("<div></div>", {
		"class" : "chapter-group ps-5"
	});


	//챕터 .input-group div
	let $inputGroup = $("<div></div>", {
		"class" : "input-group"
	});

	let $chapDelBtn = $("<button></button>", {
		"type" : "button",
		"class" : "btn p-0 me-2 chapDelBtn",
		"data-bs-toggle" : "tooltip",
		"data-bs-placement" : "left",
		"title" : "챕터 삭제"
	});

	$chapDelBtn.append("<i class='fas fa-minus-square text-warning fs-3'></i>");
	$chapDelBtn.click(chapDelBtnClickListener);

	let $chapterInput = $("<input>", {
		"type" : "text",
		"class" : "chapterInput form-control my-1",
		"placeholder" : "챕터 제목 입력"
	});

	$inputGroup.append($chapDelBtn, $chapterInput);

	//챕터 input:file
	let $chapterInputFile = $("<input>", {
		"type" : "file",
		"class" : "form-control form-control-sm",
		"name" : "chapterVideo",
		"accept" : "video/*"
	});

	//.chapter-group div에 자식요소 추가
	$chapterGroup.append($inputGroup, $chapterInputFile);

	//챕터 추가버튼 이전의 형제요소로 추가
	const $chapAddBtn = $(e.target).parents(".part-group").find(".chapAddBtn");
	$chapAddBtn.before($chapterGroup);
	tooltipInit($chapAddBtn.prev());
}

function partDelBtnClickListener(e) {
	$(e.target).parents(".part-group").remove();
	$(".tooltip").remove();
}

function chapDelBtnClickListener(e) {
	$(e.target).parents(".chapter-group").remove();
	$(".tooltip").remove();
}

function tooltipInit(elem) {
	//Bootstrap Tooltip을 사용하기 위한 tooltip 초기화 코드
	var tooltipTriggerList = [].slice.call($(elem).find('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl)
	});
}

//파트, 챕터값을 map(part, chapter[])로 만들어주기
function createCurriculum(){
	//var curMap = new Map();
	const curArr = new Array();
	const $partGroup = $("#inputCurriculum").find(".part-group");
	//console.log($partGroup);
	
	var formData = new FormData($('#lectureEnrollFrm')[0]);
	
	$partGroup.each((pIdx, elem) => {
		let $partInput = $(elem).find(".partInput");
		//curMap에 key: Part객체 생성, value: Array객체 생성

		if(!$partInput.val())
			return true;

		const lecturePart = new LecturePart(pIdx, $partInput.val());

		//curMap.set(lecturePart, new Array());
		
		

		let $chapterInputs = $(elem).find(".chapterInput");
		//console.log($chapterInputs);
		$chapterInputs.each((cIdx, elem) => {
			if(!$(elem).val()) {
				$(elem).parent().next().val("");
				return true;// jQuery의 each에서 true리턴 : continue, false리턴 : break;
			}
			//let chapArr = curMap.get(lecturePart);
			
			if($(elem).parent().next().val())

			//console.log(chapArr);
			let lectureChapter = new LectureChapter(cIdx, $(elem).val(), null);
			//chapArr.push(lectureChapter);
			lecturePart.chapterArr.push(lectureChapter);
		});
		curArr.push(lecturePart);

	});
	//console.log(curMap);
	console.log("curArr", curArr);

	const jsonStr = JSON.stringify(curArr);
	console.log("jsonStr", jsonStr);

	return jsonStr;
}

function LecturePart(lecturePartNo, lecturePartTitle) {
	this.lecturePartNo = lecturePartNo;
	this.lecturePartTitle = lecturePartTitle;
	this.chapterArr = new Array();
}

function LectureChapter(lecChapterNo, lecChapterTitle, lecChapterVideo) {
	this.lecChapterNo = lecChapterNo;
	this.lecChapterTitle = lecChapterTitle;
	this.lecChapterVideo = lecChapterVideo;
}