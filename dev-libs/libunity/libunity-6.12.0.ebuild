# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16

inherit vala autotools-utils

DESCRIPTION="A library for instrumenting- and integrating with all aspects of the Unity shell"
HOMEPAGE="http://launchpad.net/libunity"
SRC_URI="http://launchpad.net/${PN}/6.0/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="
	dev-libs/dee
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/libdbusmenu:3
	dev-libs/libgee
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig"

src_prepare() {
	autotools-utils_src_prepare
	vala_src_prepare
}
