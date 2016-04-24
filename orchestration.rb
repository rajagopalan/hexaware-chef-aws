require 'chef/provisioning/aws_driver'

with_driver 'aws::us-east-1' do
  with_machine_options :ssh_username => 'ec2-user',
    :bootstrap_options => {      
      :image_id => 'ami-2051294a',
      :key_name => 'cdsimplified',
      :instance_type => 't2.micro',
      :security_group_ids => 'sg-c92d84b1'
    }


  machine'web-box-1f' do
    action :converge
    run_list ['serversetup::install-packages']
  end
  load_balancer 'chef' do
	machines ['web-box-1f']
  end
end





