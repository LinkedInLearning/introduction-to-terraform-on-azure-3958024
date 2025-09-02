# Introduction to Terraform on Azure
This is the repository for the LinkedIn Learning course `Introduction to Terraform on Azure`. The full course is available from [LinkedIn Learning][lil-course-url].

![lil-thumbnail-url]

## Course Description

In this course Prince Mokut—a certified Cloud and DevOps engineer—teaches intermediate cloud and DevOps professionals how to harness the power of Terraform to manage and automate Azure infrastructure. Learn how to configure Terraform, set up Azure credentials, and write effective configurations using HCL. Explore best practices for variables and state management with Azure Blob Storage. Dive into advanced topics, such as creating reusable modules, managing multiple environments with workspaces, and integrating CI/CD pipelines using Azure DevOps. Plus, gain practical experience deploying key Azure resources and establishing temporary QA environments for rapid testing. By the end of the course, you will be equipped with the skills to build, secure and tear down production-ready infrastructure on Azure using Terraform.

_See the readme file in the main branch for updated instructions and information._
## Instructions
This repository has branches for each of the videos in the course. You can use the branch pop up menu in github to switch to a specific branch and take a look at the course at that stage, or you can add `/tree/BRANCH_NAME` to the URL to go to the branch you want to access.

## Branches
The branches are structured to correspond to the videos in the course. The naming convention is `CHAPTER#_MOVIE#`. As an example, the branch named `02_03` corresponds to the second chapter and the third video in that chapter. 
Some branches will have a beginning and an end state. These are marked with the letters `b` for "beginning" and `e` for "end". The `b` branch contains the code as it is at the beginning of the movie. The `e` branch contains the code as it is at the end of the movie. The `main` branch holds the final state of the code when in the course.

When switching from one exercise files branch to the next after making changes to the files, you may get a message like this:

    error: Your local changes to the following files would be overwritten by checkout:        [files]
    Please commit your changes or stash them before you switch branches.
    Aborting

To resolve this issue:
	
    Add changes to git using this command: git add .
	Commit changes using this command: git commit -m "some message"

## Instructor

Prince Mokut

System, Cloud, and DevOps Engineer               

Check out my other courses on [LinkedIn Learning](https://www.linkedin.com/learning/instructors/prince-mokut?u=104).


[0]: # (Replace these placeholder URLs with actual course URLs)

[lil-course-url]: https://www.linkedin.com/learning/introduction-to-terraform-on-azure-29753110
[lil-thumbnail-url]: https://media.licdn.com/dms/image/v2/D4D0DAQFVJosgL7pnqw/learning-public-crop_675_1200/B4DZjy3oLBIcAY-/0/1756421325814?e=2147483647&v=beta&t=3fXEqG_By26gaNHjUNHxSGHHE7AxpfTQZ_LfmanfuNg

