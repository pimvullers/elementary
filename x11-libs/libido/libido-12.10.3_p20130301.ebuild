# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit vala autotools-utils

DESCRIPTION="Widgets and other objects used for indicators"
HOMEPAGE="https://launchpad.net/ido"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/ido_12.10.3daily13.03.01.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE="doc static-libs"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=x11-libs/gtk+-3.4:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )"

DOCS=( AUTHORS COPYING ChangeLog NEWS README TODO )
S="${WORKDIR}/ido-12.10.3daily13.03.01"
AUTOTOOLS_AUTORECONF=1

src_prepare() {
	# Remove reference to ubuntu gtk+ patch
	sed -i 's/ubuntu_//' src/idoscalemenuitem.c

	# Remove GTK_DOC_CHECK if documentation is not enabled
	use doc || sed -i 's/GTK_DOC_CHECK(\[1.8\])//' configure.ac

	vala_src_prepare
	autotools-utils_src_prepare
}

src_configure() {
	autotools-utils_src_configure VALA_API_GEN="${VAPIGEN}"
}