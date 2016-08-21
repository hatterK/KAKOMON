Member.create(
    name: "user",
    password: "pass",
    password_confirmation: "pass",
    access_authority: 3
)

Member.create(
    name: "editor",
    password: "pass",
    password_confirmation: "pass",
    access_authority: 2
)

Member.create(
    name: "super",
    password: "pass",
    password_confirmation: "pass",
    access_authority: 1
)
