# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit meson vala xdg

DESCRIPTION="Elementary OS library that extends GTK+"
HOMEPAGE="https://github.com/elementary/granite"
SRC_URI="https://github.com/elementary/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0/${PV}"
KEYWORDS="amd64 ~arm ~x86"
IUSE="doc"

BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
DEPEND="
	>=dev-libs/glib-2.50:2
	>=x11-libs/gtk+-3.22:3[introspection]
	dev-libs/libgee:0.8[introspection]
"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Ddocumentation=$(usex doc true false)
	)
	meson_src_configure
}
