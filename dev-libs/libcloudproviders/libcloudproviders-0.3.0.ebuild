# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit meson vala

DESCRIPTION="Cloudproviders integration API"
HOMEPAGE="https://gitlab.gnome.org/World/libcloudproviders"
SRC_URI="https://gitlab.gnome.org/World/libcloudproviders/-/archive/${PV}/libcloudproviders-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc introspection vala"

DEPEND="
	doc? ( dev-util/gdbus-codegen )
	virtual/pkgconfig
"
BDEPEND="${DEPEND}
	>=dev-libs/glib-2.51.2:2
	introspection? ( dev-libs/gobject-introspection:= )
"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dintrospection=$(usex introspection true false)
		-Dvapigen=$(usex vala true false)
		-Denable-gtk-doc=$(usex doc true false)
		-Dtest=false
	)
	meson_src_configure
}
