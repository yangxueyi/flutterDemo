class HomeBeanEntity {
	HomeBeanBusinessobject businessObject;
	bool success;
	bool failure;
	String resultCode;
	String resultCodeMsg;

	HomeBeanEntity({this.businessObject, this.success, this.failure, this.resultCode, this.resultCodeMsg});

	HomeBeanEntity.fromJson(Map<String, dynamic> json) {
		businessObject = json['businessObject'] != null ? new HomeBeanBusinessobject.fromJson(json['businessObject']) : null;
		success = json['success'];
		failure = json['failure'];
		resultCode = json['resultCode'];
		resultCodeMsg = json['resultCodeMsg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.businessObject != null) {
      data['businessObject'] = this.businessObject.toJson();
    }
		data['success'] = this.success;
		data['failure'] = this.failure;
		data['resultCode'] = this.resultCode;
		data['resultCodeMsg'] = this.resultCodeMsg;
		return data;
	}
}

class HomeBeanBusinessobject {
	List<HomeBeanBusinessobjectNewslist> newsList;
	List<HomeBeanBusinessobjectBannerlist> bannerList;
	List<HomeBeanBusinessobjectLoanlist> loanList;
	List<HomeBeanBusinessobjectCrowdlist> crowdList;

	HomeBeanBusinessobject({this.newsList, this.bannerList, this.loanList, this.crowdList});

	HomeBeanBusinessobject.fromJson(Map<String, dynamic> json) {
		if (json['newsList'] != null) {
			newsList = new List<HomeBeanBusinessobjectNewslist>();(json['newsList'] as List).forEach((v) { newsList.add(new HomeBeanBusinessobjectNewslist.fromJson(v)); });
		}
		if (json['bannerList'] != null) {
			bannerList = new List<HomeBeanBusinessobjectBannerlist>();(json['bannerList'] as List).forEach((v) { bannerList.add(new HomeBeanBusinessobjectBannerlist.fromJson(v)); });
		}
		if (json['loanList'] != null) {
			loanList = new List<HomeBeanBusinessobjectLoanlist>();(json['loanList'] as List).forEach((v) { loanList.add(new HomeBeanBusinessobjectLoanlist.fromJson(v)); });
		}
		if (json['crowdList'] != null) {
			crowdList = new List<HomeBeanBusinessobjectCrowdlist>();(json['crowdList'] as List).forEach((v) { crowdList.add(new HomeBeanBusinessobjectCrowdlist.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.newsList != null) {
      data['newsList'] =  this.newsList.map((v) => v.toJson()).toList();
    }
		if (this.bannerList != null) {
      data['bannerList'] =  this.bannerList.map((v) => v.toJson()).toList();
    }
		if (this.loanList != null) {
      data['loanList'] =  this.loanList.map((v) => v.toJson()).toList();
    }
		if (this.crowdList != null) {
      data['crowdList'] =  this.crowdList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class HomeBeanBusinessobjectNewslist {
	String wxImageUrl;
	String newsId;
	String imageUrl;
	String wxTitle;
	String title;
	String wxDesc;

	HomeBeanBusinessobjectNewslist({this.wxImageUrl, this.newsId, this.imageUrl, this.wxTitle, this.title, this.wxDesc});

	HomeBeanBusinessobjectNewslist.fromJson(Map<String, dynamic> json) {
		wxImageUrl = json['wxImageUrl'];
		newsId = json['newsId'];
		imageUrl = json['imageUrl'];
		wxTitle = json['wxTitle'];
		title = json['title'];
		wxDesc = json['wxDesc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['wxImageUrl'] = this.wxImageUrl;
		data['newsId'] = this.newsId;
		data['imageUrl'] = this.imageUrl;
		data['wxTitle'] = this.wxTitle;
		data['title'] = this.title;
		data['wxDesc'] = this.wxDesc;
		return data;
	}
}

class HomeBeanBusinessobjectBannerlist {
	String wxImageUrl;
	String eventId;
	String isSkip;
	String imageUrl;
	String linkUrl;
	String id;
	String wxTitle;
	String title;
	String wxDesc;

	HomeBeanBusinessobjectBannerlist({this.wxImageUrl, this.eventId, this.isSkip, this.imageUrl, this.linkUrl, this.id, this.wxTitle, this.title, this.wxDesc});

	HomeBeanBusinessobjectBannerlist.fromJson(Map<String, dynamic> json) {
		wxImageUrl = json['wxImageUrl'];
		eventId = json['eventId'];
		isSkip = json['isSkip'];
		imageUrl = json['imageUrl'];
		linkUrl = json['linkUrl'];
		id = json['id'];
		wxTitle = json['wxTitle'];
		title = json['title'];
		wxDesc = json['wxDesc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['wxImageUrl'] = this.wxImageUrl;
		data['eventId'] = this.eventId;
		data['isSkip'] = this.isSkip;
		data['imageUrl'] = this.imageUrl;
		data['linkUrl'] = this.linkUrl;
		data['id'] = this.id;
		data['wxTitle'] = this.wxTitle;
		data['title'] = this.title;
		data['wxDesc'] = this.wxDesc;
		return data;
	}
}

class HomeBeanBusinessobjectLoanlist {
	String increaseInterestCouponFlag;
	String investorNum;
	String loanType;
	String cashCouponFlag;
	String termCount;
	String addRate;
	String progressRate;
	String yearRate;
	String repayType;
	String redMoneyUse;
	String loanName;
	String loanStatus;
	String loanStatusDesc;
	String surplusAmount;
	String borrowType;
	String openTime;
	String loanId;
	String termUnit;
	String startInterest;

	HomeBeanBusinessobjectLoanlist({this.increaseInterestCouponFlag, this.investorNum, this.loanType, this.cashCouponFlag, this.termCount, this.addRate, this.progressRate, this.yearRate, this.repayType, this.redMoneyUse, this.loanName, this.loanStatus, this.loanStatusDesc, this.surplusAmount, this.borrowType, this.openTime, this.loanId, this.termUnit, this.startInterest});

	HomeBeanBusinessobjectLoanlist.fromJson(Map<String, dynamic> json) {
		increaseInterestCouponFlag = json['increaseInterestCouponFlag'];
		investorNum = json['investorNum'];
		loanType = json['loanType'];
		cashCouponFlag = json['cashCouponFlag'];
		termCount = json['termCount'];
		addRate = json['addRate'];
		progressRate = json['progressRate'];
		yearRate = json['yearRate'];
		repayType = json['repayType'];
		redMoneyUse = json['redMoneyUse'];
		loanName = json['loanName'];
		loanStatus = json['loanStatus'];
		loanStatusDesc = json['loanStatusDesc'];
		surplusAmount = json['surplusAmount'];
		borrowType = json['borrowType'];
		openTime = json['openTime'];
		loanId = json['loanId'];
		termUnit = json['termUnit'];
		startInterest = json['startInterest'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['increaseInterestCouponFlag'] = this.increaseInterestCouponFlag;
		data['investorNum'] = this.investorNum;
		data['loanType'] = this.loanType;
		data['cashCouponFlag'] = this.cashCouponFlag;
		data['termCount'] = this.termCount;
		data['addRate'] = this.addRate;
		data['progressRate'] = this.progressRate;
		data['yearRate'] = this.yearRate;
		data['repayType'] = this.repayType;
		data['redMoneyUse'] = this.redMoneyUse;
		data['loanName'] = this.loanName;
		data['loanStatus'] = this.loanStatus;
		data['loanStatusDesc'] = this.loanStatusDesc;
		data['surplusAmount'] = this.surplusAmount;
		data['borrowType'] = this.borrowType;
		data['openTime'] = this.openTime;
		data['loanId'] = this.loanId;
		data['termUnit'] = this.termUnit;
		data['startInterest'] = this.startInterest;
		return data;
	}
}

class HomeBeanBusinessobjectCrowdlist {
	String imageUrl;
	String linkUrl;
	String wxTitle;
	String title;
	String wxDesc;

	HomeBeanBusinessobjectCrowdlist({this.imageUrl, this.linkUrl, this.wxTitle, this.title, this.wxDesc});

	HomeBeanBusinessobjectCrowdlist.fromJson(Map<String, dynamic> json) {
		imageUrl = json['imageUrl'];
		linkUrl = json['linkUrl'];
		wxTitle = json['wxTitle'];
		title = json['title'];
		wxDesc = json['wxDesc'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imageUrl'] = this.imageUrl;
		data['linkUrl'] = this.linkUrl;
		data['wxTitle'] = this.wxTitle;
		data['title'] = this.title;
		data['wxDesc'] = this.wxDesc;
		return data;
	}
}
