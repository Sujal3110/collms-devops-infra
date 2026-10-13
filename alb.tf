resource "aws_lb" "app" {
  name               = "${var.project_name}-${var.environment}-alb-1"
  load_balancer_type = "application"
  internal           = false
  security_groups    = [aws_security_group.alb.id]
  subnets            = aws_subnet.app_web_public[*].id

  tags = {
    Name = "${var.project_name}-${var.environment}-alb-1"
  }
}

resource "aws_lb_target_group" "eks_nodes" {
  name        = "${var.project_name}-${var.environment}-eks-tg"
  port        = var.node_port
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.app.id

  health_check {
    path    = "/"
    matcher = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.eks_nodes.arn
  }
}

# Register every worker node in the target group automatically
resource "aws_autoscaling_attachment" "eks_nodes" {
  autoscaling_group_name = aws_eks_node_group.main.resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = aws_lb_target_group.eks_nodes.arn
}

# Allow the ALB to reach the nodes on the NodePort range
resource "aws_vpc_security_group_ingress_rule" "nodes_from_alb" {
  security_group_id            = aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
  referenced_security_group_id = aws_security_group.alb.id
  from_port                    = 30000
  to_port                      = 32767
  ip_protocol                  = "tcp"
  description                  = "Traffic from the ALB to Kubernetes NodePorts"
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}