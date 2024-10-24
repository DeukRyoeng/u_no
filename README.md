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
     페이지 : 지도뷰
     Po클릭 이벤트, 맵 라이프라사이클, firebase통신, 현재위치불러오기, 카메라이동

<br>
    
### 점승현

- **UI, Function**
페이지 : 킥보드 등록 페이지
현재 위치 찾기 기능
킥보드 배터리 정보 등록
킥보드 등록 기능

<br>

### 백시훈
- **UI, Function**
page
마이페이지 뷰
로그아웃 기능
내가 등록한 킥보드, 킥보드 이용내역 테이블 뷰
현재 유저 status(이용중인 킥보드, 배터리)
마이페이지 뷰
로그아웃 기능
내가 등록한 킥보드, 킥보드 이용내역 테이블 뷰
현재 유저 status(이용중인 킥보드, 배터리)
렌트모달 뷰
킥보드 ID, 이미지, 배터리, 주행가능거리 표시
UITabBar , NavigationViewController
네비게이션컨트롤러에서 탭바로 이동 후 탭바는 각각의 네비게이션 컨트롤러를 가지고
각각 네비게이션 아이템, 타이틀을 가짐, 로그아웃시 처음 화면으로 돌아가기
<br>

### 개발 ~ 배포 기간 : 2024-08-29 ~ 2024-09-30 (day 31)
<br>

## 개발내용

<br>

### 이득령

#### RestAPI
내용요요요ㅛ용
<br>

#### FCM
<br>

#### Apple, Kakao SignIn


<br>

### 점승현

<br>

### 백시훈
