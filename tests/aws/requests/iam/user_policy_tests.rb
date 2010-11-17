Shindo.tests('AWS::IAM | user policy requests', ['aws']) do

  AWS[:iam].create_user('fog_user_policy_tests')

  tests('success') do

    @policy = {"Statement" => [{"Effect" => "Allow", "Action" => "*", "Resource" => "*"}]}

    tests("#put_user_policy('fog_user_policy_tests', 'fog_policy', #{@policy.inspect})").formats(AWS::IAM::Formats::BASIC) do
      AWS[:iam].put_user_policy('fog_user_policy_tests', 'fog_policy', @policy).body
    end

    @user_policies_format = {
      'IsTruncated' => Fog::Boolean,
      'PolicyNames' => [String],
      'RequestId'   => String
    }

    tests("list_user_policies('fog_user_policy_tests')").formats(@user_policies_format) do
      AWS[:iam].list_user_policies('fog_user_policy_tests').body
    end

    tests("#delete_user_policy('fog_user_policy_tests', 'fog_policy')").formats(AWS::IAM::Formats::BASIC) do
      AWS[:iam].delete_user_policy('fog_user_policy_tests', 'fog_policy').body
    end

  end

  tests('failure') do
    test('failing conditions')
  end

  AWS[:iam].delete_user('fog_user_policy_tests')

end