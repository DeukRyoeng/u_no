# 🛴 알고싶어 - 오늘의 

![제목 없는 디자인](https://github.com/user-attachments/assets/f959bed8-bbc2-44d1-a519-052620851fb5)
<br>

## 프로젝트 소개
RestAPI를 활용하여 농수산물 시세를 보여줍니다
<br>

## 팀원 구성
<div align="center">
  
| **이득령** | **점승현** | **백시훈** | 
| :------: |  :------: | :------: |
| [<img src="https://avatars.githubusercontent.com/u/164954344?v=4" height=150 width=150> <br/> @dx._.xk7](https://github.com/DeukRyoeng) | [<img src="https://avatars.githubusercontent.com/u/168401241?v=4" height=150 width=150> <br/> @Jeom1028](https://github.com/Jeom1028) | [<img src="https://github.com/user-attachments/assets/7a3e9243-d653-4bae-ae6f-b9dcb564b2d8" height=150 width=150> <br/> @likelyLime](https://github.com/LikelyLime) |

</div>

<br>

## 1. 개발 환경

- Front : UIkit, SnapKit,Rxswift
- Back-end : Firebase
- 버전 및 이슈관리 : Github 
- 협업 툴 : Slack, Notion, Zep
- 
<br>

## 2. 브랜치 전략
### 브랜치 전략

- Git-flow 전략을 기반으로 main, develop 브랜치와 Name 보조 브랜치를 운용했습니다.
- main, develop, Feat 브랜치로 나누어 개발을 하였습니다.
    - **main** 브랜치는 배포 단계에서만 사용하는 브랜치입니다.
    - **dev** 브랜치는 개발 단계에서 git-flow의 master 역할을 하는 브랜치입니다.
<br>

## 3. 프로젝트 구조

```
├── Base.lproj
│   └── LaunchScreen.storyboard
├── Common
│   ├── ColorExtension.swift
│   ├── Common.swift
│   ├── EetworkManager.swift
│   └── EndPoint.swift
├── Config
│   ├── AppDelegate.swift
│   ├── Assets.xcassets
│   │   ├── AppIcon.appiconset
│   │   │   ├── Contents.json
│   │   │   └── u_no.png
│   │   ├── Contents.json
│   │   ├── Deuk.imageset
│   │   │   ├── Contents.json
│   │   │   └── Deuk.png
│   │   ├── Jeom.imageset
│   │   │   ├── Contents.json
│   │   │   └── Jeom.png
│   │   ├── Launch.imageset
│   │   │   ├── Contents.json
│   │   │   └── Launch.png
│   │   ├── Lime.imageset
│   │   │   ├── Contents.json
│   │   │   └── Lime.png
│   │   ├── Minwoo.imageset
│   │   │   ├── Contents.json
│   │   │   └── Minwoo.png
│   │   ├── applebtn.imageset
│   │   │   ├── Contents.json
│   │   │   └── applebtn.png
│   │   ├── kakaobtn.imageset
│   │   │   ├── Contents.json
│   │   │   └── KakaoLogin.png
│   │   ├── mainTitle.imageset
│   │   │   ├── Contents.json
│   │   │   └── mainTitle.png
│   │   └── signUp.imageset
│   │       ├── Contents.json
│   │       └── SiginUp.png
│   ├── GoogleService-Info.plist
│   ├── SceneDelegate.swift
│   └── TabbarController.swift
├── Favorites
│   ├── FavoritesController.swift
│   ├── FavoritesModel.swift
│   ├── FavoritesView.swift
│   ├── FavoritesViewModel.swift
│   └── SwipeableCollectionViewCell.swift
├── Graph
│   ├── GraphModel.swift
│   ├── GraphView.swift
│   ├── GraphViewController.swift
│   └── GraphViewModel.swift
├── Info.plist
├── Main
│   ├── HalfModalPresentationController.swift
│   ├── MainModel.swift
│   ├── MainSectionHeaderView.swift
│   ├── MainViewController.swift
│   ├── MainViewFirstCell.swift
│   ├── MainViewModel.swift
│   ├── MainViewSecoundCell.swift
│   └── PriceFilterViewController.swift
├── Search
│   ├── ItemManager.swift
│   ├── SearchTableViewCell.swift
│   ├── SearchView.swift
│   ├── SearchViewController.swift
│   └── SearchViewModel.swift
├── Setting
│   ├── ConfirmationViewController.swift
│   ├── People
│   │   ├── PeopleCell.swift
│   │   ├── PeopleController.swift
│   │   └── PeopleView.swift
│   ├── SettingCell.swift
│   ├── SettingController.swift
│   ├── SettingModel.swift
│   ├── SettingView.swift
│   └── SettingViewModel.swift
└── u_no.entitlements

```

<br>

## 4. 역할 분담

### 이득령

- **UI, Function**
페이지 : API연동 및 로그인화면


<br>
    
### 점승현

- **UI, Function**
페이지 : 홈 화면, 즐겨찾기 화면, 설정화면
CoreData설정

<br>

### 백시훈
- **UI, Function**
페이지 : 검색화면 및 그래프 화면

<br>

### 개발 ~ 배포 기간 : 2024-08-29 ~ 2024-09-30 (day 31)
<br>

## 개발내용

<br>

### 이득령

#### RestAPI
API연동 및 로그인, 회원탈퇴 기능ㅈ
<br>

#### FCM
<br>

#### 


<br>

### 점승현
CollectionView을 이용여 농산물의 최고 하락, 상승 품목을 나타내는 기능
CoreData를 이용한 홈화면과 즐겨찾기 기능
<br>

### 백시훈
charts라이브러리를 이용한 농산물 가격 그래프 기능
RxSwift를 이용한 자동완성기능이 있는 검색기능
