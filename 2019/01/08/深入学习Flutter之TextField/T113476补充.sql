-- 采购订单行子项目与头部项目信息匹配
SELECT DISTINCT po.name -- 采购订单号
    FROM purchase_order as po, -- 采购订单头
    purchase_order_line pl, -- 采购订单行
    emabc_project_subjob as  sj -- 项目子项目
    WHERE po.id = pl.order_id -- 采购订单行和采购订单头拼接
          AND sj.id = pl.subjob_id -- 采购订单行与项目子项目拼接
          AND po.project_id != sj.project_id; -- 采购订单头的项目与采购订单行子项目对应的项目不匹配筛选

-- 采购订单成本任务与头部项目信息匹配
SELECT DISTINCT po.name,b.id -- 采购订单号
    FROM purchase_order as po, -- 采购订单头
    purchase_order_line as pl, -- 采购订单行
    emabc_project_budget_line as  bl, --成本任务
    emabc_project_budget b -- 预算
    WHERE po.id = pl.order_id -- 采购订单行和采购订单头拼接
          AND bl.id = pl.budget_id
          AND bl.project_id = b.id
          AND b.project_number != po.project_id
          AND po.order_type in ('enable_project_purchase_material','subcontract','enable_project_purchase_machines', 'enable_project_purchase_others');
