set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

if(IS_MSVC)
    find_package(Glog REQUIRED)
    if(DEFINED glog_VERSION_MAJOR)
        # Older versions of glog don't export version variables.
        add_definitions("-DGLOG_VERSION_MAJOR=${glog_VERSION_MAJOR}")
        add_definitions("-DGLOG_VERSION_MINOR=${glog_VERSION_MINOR}")
    endif()
endif()

find_package(Eigen3 3.4 REQUIRED)
find_package(SuiteSparse COMPONENTS CHOLMOD REQUIRED)
find_package(Ceres REQUIRED COMPONENTS SuiteSparse)
find_package(Boost REQUIRED)

if(TESTS_ENABLED)
    message(STATUS "Enabling tests")
    find_package(GTest REQUIRED)
endif()

if (OPENMP_ENABLED)
    message(STATUS "Enabling OpenMP")
    find_package(OpenMP REQUIRED)
endif()

include(FetchContent)
FetchContent_Declare(PoseLib
    GIT_REPOSITORY    https://github.com/PoseLib/PoseLib.git
    GIT_TAG           b3691b791bcedccd5451621b2275a1df0d9dcdeb
    EXCLUDE_FROM_ALL
)
message(STATUS "Configuring PoseLib...")
if (FETCH_POSELIB) 
    FetchContent_MakeAvailable(PoseLib)
else()
    find_package(PoseLib REQUIRED)
endif()
message(STATUS "Configuring PoseLib... done")

FetchContent_Declare(COLMAP
    GIT_REPOSITORY    https://github.com/colmap/colmap.git
    GIT_TAG           66fd8e56a0d160d68af2f29e9ac6941d442d2322
    EXCLUDE_FROM_ALL
)
message(STATUS "Configuring COLMAP...")
set(UNINSTALL_ENABLED OFF CACHE INTERNAL "")
if (FETCH_COLMAP) 
    FetchContent_MakeAvailable(COLMAP)
else()
    find_package(COLMAP REQUIRED)
endif()
message(STATUS "Configuring COLMAP... done")
