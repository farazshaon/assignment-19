import { NextResponse } from "next/server";
import { PrismaClient } from "@prisma/client";



export async function POST(req, res) {

//! Aggregate (avg,count,max,min,sum)
  //   try {
  //     const prisma = new PrismaClient();
  //    const result = await prisma.product.aggregate({
//       _avg: { salary: true },
//       _count: { salary: true },
//       _max: { salary: true },
//       _min: { salary: true },
//       _sum: { salary: true },
// });

  //     return NextResponse.json({ status: "Success", result: result });
  //   } catch (err) {
  //     return NextResponse.json({ status: "Fail", result: err.toString() });
  //   }

  //!  Aggregate (groupBy,having)
  //   try {
  //     const prisma = new PrismaClient();
  //     const result = await prisma.order.groupBy({
//        by: ["city"],
//        _count: { grandTotal: true },
// })

  //     return NextResponse.json({ status: "Success", result: result });
  //   } catch (err) {
  //     return NextResponse.json({ status: "Fail", result: err.toString() });
  //   }

  //!  Read All Data
  //   try {
  //     const prisma = new PrismaClient();
  //     let result = await prisma.post_comment.findMany();

  //     return NextResponse.json({ status: "Success", result: result });
  //   } catch (err) {
  //     return NextResponse.json({ status: "Fail", result: err.toString() });
  //   }




  //!  Transactions & Rollback
  //   try {
  //     const prisma = new PrismaClient();

  //     const createUser = prisma.user.create({
  //   data:{email:"johndoe.doe@example.com", password:"123"}
  // })

  // const deleteComment=prisma.product.delete({
  //     where:{id:5}
  // })
  //     return NextResponse.json({ status: "Success", result: result });
  //   } catch (err) {
  //     return NextResponse.json({ status: "Fail", result: err.toString() });
  //   }



}