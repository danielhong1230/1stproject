# rawdata 파일을 읽기 위해 지정된 경로에 존재하는 파일 목록을 불러온다.
filelist <- list.files("C:/Users/BongKiHong/Dropbox/R_work_directory/R_code/rawdata")
head(filelist)
class(filelist)

# 'rawdata.txt'파일을 경로를 설정하여 'my_data'라는 table로 불러온다.
my_data <- read.table("C:/Users/BongKiHong/Dropbox/R_work_directory/R_code/rawdata/rawdata.txt", sep="\t", quote="", stringsAsFactors=FALSE,header=TRUE)
dataset_df <- dplyr::tbl_df(my_data)
head(dataset_df)

# class(my_data)
# class(dataset_df)
# str(my_data)
# str(dataset_df)

# 테이블의 헤더에 대한 리스트 작성
head.list <- names(my_data)
head.list
# head.list.CEL <- grep("CEL", head.list)
# c(1, head.list.CEL)
# my_data.CEL <- dplyr::tbl_df(my_data[:, c(1, head.list.CEL)]) # 일단 실패함...

# dplyr의 select 함수 사용하여 my_data에서 probeid와 16개 샘플에 대한 intensity값을 선택하여 my_data.CEL로 불러옴.
my_data.CEL <- dplyr::select(my_data, probeset_id, X180727_1_EXP_5P_1_W_.MoGene.2_0.st..CEL:X180727_16_EXP_23K_8_.MoGene.2_0.st..CEL)

# preporcessCore를 사용하여 quantile normalization 시행.
head(my_data.CEL)
rownames(my_data.CEL) <- my_data.CEL[,1] # my_data.CEL의 rowname을 probe id로 치환함.
data_mat <- data.matrix(my_data.CEL[,-1]) # my_data.CEL의 probe id열을 제외한 intensity value들을 data_mat로 지정함.
head(data_mat)
data_norm <- preprocessCore::normalize.quantiles(data_mat, copy = TRUE)
rownames(data_norm) <- my_data.CEL[,1] # 행 이름을 probe id로 지정함.
colnames(data_norm) = paste0("C", 1:16) # 열 이름을 C1 부터 C16으로 지정함.
head(data_norm)
# colnames(data_norm) <- my_data.CEL[1,c(2:17)]
# names(my_data.CEL)

# fold change 값을 구함.
# 이 후 quantile normalized dataset에 annotation을 지정함.
# 모든 데이터를 합침.

