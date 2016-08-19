
base_dir <- "~/workspace/Zika Data/kallisto_output/"
file_dirs <- list("SRR3191542", "SRR3191543", "SRR3191544", "SRR3191545")
file_dirs <- sapply(file_dirs, function(x) file.path(base_dir, x, "abundance.tsv"))

print (file_dirs)
f <- read.table(file_dirs[1],header=TRUE)
print (nrow(f))
print (f[1:3,])
for (i in 2:length(file_dirs)) {
	new <- read.table(file.path(file_dirs[i]), header=TRUE)	
	print (nrow(new))
	print (new[1:3,])
	f <- merge(f, new, by.x="target_id", by.y="target_id")
	print(f[1:3,])
}
