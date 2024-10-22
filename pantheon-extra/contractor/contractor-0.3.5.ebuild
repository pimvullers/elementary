# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson vala

DESCRIPTION="A desktop-wide extension service"
HOMEPAGE="https://github.com/elementary/contractor"
SRC_URI="https://github.com/elementary/contractor/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	$(vala_depend)
	sys-devel/gettext
	virtual/pkgconfig
"

RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/libgee:0.8
	sys-apps/dbus
"

src_prepare() {
	eapply_user
	vala_setup
}
