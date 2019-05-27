library(dplyr)
library(stringr)
library(tidyr)
setwd("C:/Users/Emma/Desktop/Enron/")

#reading in a subset of the data
emails=read.csv("emails.csv",nrows=1000, stringsAsFactors = F)
#head(emails)


#splitting the data by the new paragraph tag using 16 categories
#splits data into message
email_text=as.data.frame(str_split_fixed(emails$message, "\n\n", 2))
names(email_text)=c("Headings", "Body")
#str_sub= subsets it after the field name; str_extract matches first time it sees pattern and extracts it
Messageid=(str_sub(str_extract(email_text$Headings,"Message-ID:.*"),start=12))
Date=(str_sub(str_extract(email_text$Headings,"Date:.*"),start=7))
From=(str_sub(str_extract(email_text$Headings,"From:.*"),start=7))
To=(str_sub(str_extract(email_text$Headings,"To:.*"),start=5))
Subject=(str_sub(str_extract(email_text$Headings,"Subject:.*"),start=10))
Mimeversion=(str_sub(str_extract(email_text$Headings,"Mime-Version:.*"),start=15))
Contenttype=(str_sub(str_extract(email_text$Headings,"Content-Type:.*"),start=15))
Contentencoding=(str_sub(str_extract(email_text$Headings,"Content-Transfer-Encoding:.*"),start=28))
cc=(str_sub(str_extract(email_text$Headings,"X-cc:.*"),start=7))
bcc=(str_sub(str_extract(email_text$Headings,"X-bcc:.*"),start=8))
Folder=(str_sub(str_extract(email_text$Headings,"X-Folder:.*"),start=11))
origin=(str_sub(str_extract(email_text$Headings,"X-Origin:.*"),start=11))
filename=(str_sub(str_extract(email_text$Headings,"X-FileName:.*"),start=12))

emails_split=data.frame(Messageid,Date,From,To,Subject,Mimeversion,Contentencoding,Contenttype,cc,bcc,Folder,origin, filename,email_text$Body,stringsAsFactors=FALSE)
